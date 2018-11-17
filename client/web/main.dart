import 'dart:html';
import 'dart:web_gl';
import 'dart:async';
import 'package:http/browser_client.dart';
import 'package:jaguar_resty/jaguar_resty.dart';

import 'package:client/objects/objects.dart';

import 'package:client/ezwebgl/ezwebgl.dart';

import 'package:client/painters/terrain.dart';
import 'package:client/painters/military.dart';
import 'package:client/painters/building.dart';
import 'package:client/painters/tiles_highlight.dart';

import 'package:client/ui/ui.dart';

void main() async {
  globalClient = BrowserClient();

  CanvasElement gameCanvas = querySelector("#game-canvas");
  RenderingContext2 gl = gameCanvas.getContext("webgl2");

  gl.enable(WebGL.BLEND);
  gl.blendFunc(WebGL.SRC_ALPHA, WebGL.ONE_MINUS_SRC_ALPHA);

  final state = State(gl: gl);

  Function adjust = () {
    int width = gameCanvas.clientWidth;
    int height = gameCanvas.clientHeight;

    state.size = Point<int>(width, height);

    gameCanvas.width = width;
    gameCanvas.height = height;
    gl.viewport(0, 0, width, height);

    /*
    state.projectionMatrix =
        Mat4.ortho(0.0, width.toDouble(), height.toDouble(), 0.0, 1.0, -1.0);
        */

    state.projectionMatrix = Mat4.ortho(
        -width / 2, width / 2, height / 2, -height / 2, -1000.0, 1000.0);
  };

  window.onLoad.listen((_) => adjust());

  ResizeObserver((_, _1) {
    adjust();
  }).observe(gameCanvas);

  Function init = () async {
    await TerrainPainter.bootstrap(gl);
    // await MilitaryPainter.bootstrap(gl);
    await BuildingPainter.bootstrap(gl);
    await TileHighlightPainter.bootstrap(gl);
  };

  await init();

  final terrain = Terrain();
  // final military = Military();
  final barrack = Building(
      size: Point<double>(295.0, 207.0), pos: Position2(), spriteId: 2);
  final bamboo =
      Building(size: Point<double>(78.0, 90.0), pos: Position2(), spriteId: 2);
  final highlight = TileHighlight();

  Function loop = () {
    state.newLoop(gl);

    gl.clearColor(0, 0, 0, 1);
    gl.clear(WebGL.COLOR_BUFFER_BIT | WebGL.DEPTH_BUFFER_BIT);

    terrain.paint(state);
    highlight.paint(state);
    // military.paint(state);
    bamboo.paint(state);
  };

  final mouseCoordUi = MouseCoords.mount(querySelector("#mouse-coords"));

  gameCanvas.onMouseMove.listen((e) {
    mouseCoordUi.updateData(
        e.offset - Point(gameCanvas.width / 2, gameCanvas.height / 2));
  });

  loop();
  Timer.periodic(Duration(milliseconds: 100), (_) => loop());
}
