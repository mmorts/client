import 'package:meta/meta.dart';

import 'dart:math';
import 'dart:web_gl';
import 'data.dart';

import 'package:ezwebgl/ezwebgl.dart';

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
