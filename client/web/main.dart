import 'dart:html';
import 'dart:web_gl';
import 'dart:async';
import 'package:http/browser_client.dart';
import 'package:jaguar_resty/jaguar_resty.dart';

import 'package:client/objects/objects.dart';

import 'package:client/painters/terrain.dart';
import 'package:client/painters/military.dart';
import 'package:client/painters/building.dart';

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
  };

  window.onLoad.listen((_) => adjust());

  ResizeObserver((_, _1) {
    adjust();
  }).observe(gameCanvas);

  Function init = () async {
    await TerrainPainter.bootstrap(gl);
    await MilitaryPainter.bootstrap(gl);
    await BuildingPainter.bootstrap(gl);
  };

  await init();

  final terrain = Terrain();
  final military = Military();
  final building = Building();

  Function loop = () {
    state.newLoop(gl);

    gl.clearColor(0, 1, 0, 1);
    gl.clear(WebGL.COLOR_BUFFER_BIT | WebGL.DEPTH_BUFFER_BIT);

    terrain.paint(state);
    military.paint(state);
    building.paint();
  };

  loop();
  Timer.periodic(Duration(milliseconds: 100), (_) => loop());
}
