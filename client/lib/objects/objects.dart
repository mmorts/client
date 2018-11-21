import 'dart:math';
import 'dart:web_gl';

import 'package:meta/meta.dart';

import 'package:ezwebgl/ezwebgl.dart';

class Position2 {
  double x;

  double y;

  Position2({this.x: 0.0, this.y: 0.0});

  Position2 operator +(other) {
    if (other is Position2) {
      return Position2(x: x + other.x, y: y + other.y);
    } else if (other is Point) {
      return Position2(x: x + other.x, y: y + other.y);
    }
    throw Exception("Unknown operand!");
  }
}

class Position3 implements Position2 {
  double x;

  double y;

  double z;

  Position3({this.x: 0.0, this.y: 0.0, this.z: 0.0});

  Position3 operator +(other) {
    if (other is Position3) {
      return Position3(x: x + other.x, y: y + other.y, z: z + other.z);
    }
    throw Exception("Unknown operand!");
  }
}

class State {
  final DateTime startTime;

  final RenderingContext2 gl;

  // Milliseconds
  int current;

  Point<int> size;

  Mat4 projectionMatrix = Mat4();

  State({DateTime start, this.size, @required this.gl})
      : startTime = start ?? DateTime.now() {
    current = DateTime.now().difference(startTime).inMilliseconds;
    size = Point<int>(500, 500);
  }

  void newLoop(RenderingContext2 gl) {
    current = DateTime.now().difference(startTime).inMilliseconds;
  }
}
