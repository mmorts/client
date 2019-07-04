import 'dart:html';
import 'dart:web_gl';
import 'dart:async';
import 'package:client/objects/data.dart';
import 'package:http/browser_client.dart';
import 'package:jaguar_resty/jaguar_resty.dart';

import 'package:client/objects/pos.dart';
import 'package:client/objects/state.dart';
import 'package:client/objects/military.dart';

import 'package:loader/http.dart';

import 'package:ezwebgl/ezwebgl.dart';

import 'package:client/painters/terrain.dart';
import 'package:client/painters/military/military.dart';
import 'package:client/painters/building/state.dart';
import 'package:client/painters/building/painter.dart';
import 'package:client/painters/painter.dart';
import 'package:client/painters/tiles_highlight.dart';

import 'package:client/ui/ui.dart';

final iso64 = Iso.square(ortho: 64.0);

Future<void> load() async {
  // TODO
}

void main() async {
  // Setup canvas
  CanvasElement canvas = querySelector("#game-canvas");
  RenderingContext2 gl = canvas.getContext("webgl2");
  gl.enable(WebGL.BLEND);
  gl.blendFunc(WebGL.SRC_ALPHA, WebGL.ONE_MINUS_SRC_ALPHA);

  Painter painter;

  // Load data
  globalClient = BrowserClient();
  final io = HttpIo(globalClient);
  Data data = await Data.load(io);

  final state = State(gl: gl, data: data);

  // Viewport sizer
  Function adjust = () {
    int width = canvas.clientWidth;
    int height = canvas.clientHeight;

    state.size = Point<int>(width, height);

    canvas.width = width;
    canvas.height = height;
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
  }).observe(canvas);

  Game game;

  // Initialize game
  Function init = () async {
    painter = await Painter.make(gl);
    await TileHighlightPainter.bootstrap(gl);
    game = Game(state, painter, players: []);
  };
  await init();

  final terrain1 = Terrain();
  final terrain2 = Terrain()..position = Position2(x: -512.0, y: -512.0);
  final terrain3 = Terrain()..position = Position2(x: 0, y: -512.0);
  final terrain4 = Terrain()..position = Position2(x: -512.0, y: 0);
  final military = Military(1);
  final barrack = Building(null, null, pos: Position2());
  // final bamboo = Building(null, null, null, pos: Position2());
  final highlight = TileHighlight();

  game.units[military.id] = military;

  window.document.onKeyUp.listen((KeyboardEvent e) {
    print(e.key);
    military.state.dir += 1;
    // TODO
  });

  canvas.onContextMenu.listen((e) {
    e.preventDefault();
  });

  canvas.onMouseUp.listen((MouseEvent e) {
    final center = Point(canvas.width / 2, canvas.height / 2);
    final point = e.offset - center;
    final curOrtho = iso64.toOrthoTile(point);

    // TODO print("${e.offset} ${center} ${point} ${curOrtho}");
    // TODO
  });

  Function loop = () {
    state.newLoop(gl);

    gl.clearColor(0, 0, 0, 1);
    gl.clear(WebGL.COLOR_BUFFER_BIT | WebGL.DEPTH_BUFFER_BIT);

    painter.terrain.paint(terrain1, state);
    painter.terrain.paint(terrain2, state);
    painter.terrain.paint(terrain3, state);
    painter.terrain.paint(terrain4, state);

    highlight.paint(state);

    game.paint();

    // bamboo.paint(state);
    // barrack.paint(state);
  };

  final mouseCoordUi = PointView.mount(querySelector("#mouse-coords"));
  final tileCoordUi = PointView.mount(querySelector("#tile-coords"));

  canvas.onMouseMove.listen((e) {
    Point point = e.offset - Point(canvas.width / 2, canvas.height / 2);
    mouseCoordUi.updateData(point);
    final curOrtho = iso64.toOrthoTile(point);
    tileCoordUi.updateData(curOrtho);
    highlight.position = Position2(x: curOrtho.x * 64, y: curOrtho.y * 64);
  });

  loop();
  Timer.periodic(Duration(milliseconds: 100), (_) => loop());
}
