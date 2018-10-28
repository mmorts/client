import 'dart:math';
import 'dart:web_gl';

import 'package:meta/meta.dart';

class Position2 {
  double x;

  double y;

  Position2({this.x: 0.0, this.y: 0.0});
}

class Position3 implements Position2 {
  double x;

  double y;

  double z;

  Position3({this.x: 0.0, this.y: 0.0, this.z: 0.0});
}

class State {
  final DateTime startTime;

  final RenderingContext2 gl;

  int current;

  Point<int> size;

  State({DateTime start, this.size, @required this.gl})
      : startTime = start ?? DateTime.now() {
    current = DateTime.now().difference(startTime).inSeconds;
    size = Point<int>(500, 500);
  }

  void newLoop(RenderingContext2 gl) {
    current = DateTime.now().difference(startTime).inMilliseconds;
  }
}
