import 'dart:async';
import 'dart:web_gl';
import 'dart:math';

import 'package:meta/meta.dart';

import 'package:ezwebgl/ezwebgl.dart';

import 'package:client/objects/objects.dart';

TileHighlightPainter _painter;

class TileHighlightPainter {
  final RenderingContext2 gl;

  final ShaderProgram shader;

  final Buffer buffer;

  TileHighlightPainter({@required this.shader, @required this.buffer})
      : gl = shader.gl;

  void paint(Rectangle rect, {State gameState}) {
    // Set program
    shader.use();

    final mat = isometricTransformation(rect);

    shader.setUniformMatrix4fv("model", mat);
    shader.setUniformMatrix4fv("proj", gameState.projectionMatrix);

    // Set data
    DataArray()
      ..add(PosBuf.coords(x: rect.left, y: rect.top))
      ..add(PosBuf.coords(x: rect.right, y: rect.top))
      ..add(PosBuf.coords(x: rect.left, y: rect.bottom))
      ..add(PosBuf.coords(x: rect.right, y: rect.top))
      ..add(PosBuf.coords(x: rect.left, y: rect.bottom))
      ..add(PosBuf.coords(x: rect.right, y: rect.bottom))
      ..drawArrays(gl: gl, buffer: buffer);
  }

  static Future<void> bootstrap(RenderingContext2 gl) async {
    ShaderProgram shader = ShaderProgram.prepare(
      gl: gl,
      vertex: _vertexCode,
      fragment: _fragmentCode,
    );

    Buffer buffer = PosBuf.createBuffer(shader);

    _painter = TileHighlightPainter(
      shader: shader,
      buffer: buffer,
    );
  }
}

class TileHighlight {
  Position2 position = Position2(x: 0.0, y: 0.0);

  Point<double> size = Point<double>(64.0, 64.0);

  TileHighlight() {
    if (_painter == null) throw Exception("TileHighlightPainter not bootstrapped!");
  }

  void paint(State gameState) {
    _painter.paint(Rectangle(position.x, position.y, size.x, size.y),
        gameState: gameState);
  }
}

const _vertexCode = r"""
#version 300 es

in vec4 position;

uniform mat4 proj;

uniform mat4 model;

void main() {
  gl_Position = proj * model * position;
}
""";

const _fragmentCode = r"""
#version 300 es
precision mediump float;

out vec4 outColor;

void main() {
   outColor = vec4(1.0, 0.0, 0.0, 0.3);
}
""";
