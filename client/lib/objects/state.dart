import 'package:client/objects/player.dart';
import 'package:meta/meta.dart';

import 'dart:math';
import 'dart:web_gl';
import 'data.dart';

import 'package:ezwebgl/ezwebgl.dart';

import 'building.dart';
import 'military.dart';
import 'resource.dart';

import 'package:client/painters/painter.dart';
import 'package:pathing/pathing.dart';

class State {
  final Data data;

  final DateTime startTime;

  /// Webgl rendering context
  final RenderingContext2 gl;

  // Milliseconds
  int current;

  /// Viewport size
  Point<int> size;

  Mat4 projectionMatrix = Mat4();

  State({DateTime start, this.size, @required this.gl, @required this.data})
      : startTime = start ?? DateTime.now() {
    current = DateTime.now().difference(startTime).inMilliseconds;
    size = Point<int>(500, 500);
  }

  void newLoop(RenderingContext2 gl) {
    current = DateTime.now().difference(startTime).inMilliseconds;
  }
}

class Game {
  final State state;

  final Painter painter;

  final List<Player> players;

  final units = <int, Military>{};

  final buildings = <int, Building>{};

  final resources = <int, ResNode>{};

  final _pather = Pather();

  Game(this.state, this.painter, {this.players});

  void paint() {
    // TODO terrain

    for(final unit in units.values) {
      painter.military.paint(unit, state);
    }

    // TODO
  }

  Military addUnit() {
    int id = 1; // TODO
    final military = Military(id);
    units[military.id] = military;
    _pather.addMovable(military);
    return military;
  }
}
