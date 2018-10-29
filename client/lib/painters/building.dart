import 'dart:math';
import 'dart:async';
import 'dart:web_gl';

import 'package:meta/meta.dart';

import 'package:client/ezwebgl/ezwebgl.dart';

import 'package:client/objects/objects.dart';

BuildingPainter _painter;

class BuildingPainter {
  final RenderingContext2 gl;

  final ShaderProgram shader;

  final Buffer buffer;

  final Texture texture;

  BuildingPainter._(
      {@required this.shader, @required this.buffer, @required this.texture})
      : gl = shader.gl;

  static Future<void> bootstrap(RenderingContext2 gl) async {
    ShaderProgram shader = ShaderProgram.prepare(
      gl: gl,
      vertex: _vertexCode,
      fragment: _fragmentCode,
    );

    Buffer buffer = PosTexBuf.createBuffer(shader);

    Texture texture =
        await texFromUrl("sprites/building/barrack/1.png", gl: gl);

    _painter =
        BuildingPainter._(shader: shader, buffer: buffer, texture: texture);
  }

  void paint(Rectangle rect, {@required State gameState}) {
    // Set program
    shader.use();

    gl.bindTexture(WebGL.TEXTURE_2D, texture);

    var textureLocation = gl.getUniformLocation(shader.program, "u_texture");
    gl.uniform1i(textureLocation, 0);

    var resolutionLocation =
        gl.getUniformLocation(shader.program, "resolution");
    gl.uniform2f(resolutionLocation, gameState.size.x, gameState.size.y);

    // Set data
    DataArray()
      ..add(PosTexBuf(
          position: Vec4(x: rect.left, y: rect.top),
          texCoords: Vec2(x: 0.0, y: 0.0)))
      ..add(PosTexBuf(
          position: Vec4(x: rect.right, y: rect.top),
          texCoords: Vec2(x: 1.0, y: 0.0)))
      ..add(PosTexBuf(
          position: Vec4(x: rect.left, y: rect.bottom),
          texCoords: Vec2(x: 0.0, y: 1.0)))
      ..add(PosTexBuf(
          position: Vec4(x: rect.right, y: rect.top),
          texCoords: Vec2(x: 1.0, y: 0.0)))
      ..add(PosTexBuf(
          position: Vec4(x: rect.left, y: rect.bottom),
          texCoords: Vec2(x: 0.0, y: 1.0)))
      ..add(PosTexBuf(
          position: Vec4(x: rect.right, y: rect.bottom),
          texCoords: Vec2(x: 1.0, y: 1.0)))
      ..drawArrays(gl: gl, buffer: buffer);
  }
}

class Building {
  Position2 pos = Position2();

  final size = Point<double>(295.0, 207.0);

  Building() {
    if (_painter == null) throw Exception("Building not bootstrapped!");
  }

  void paint(State gameState) {
    _painter.paint(Rectangle<double>(pos.x, pos.y, size.x, size.y),
        gameState: gameState);
  }
}

const _vertexCode = r"""
#version 300 es
in vec4 position;
in vec2 texcoord;

uniform vec2 resolution;
 
// uniform mat4 u_matrix;

out vec2 v_texcoord;

vec4 resPos;
 
void main() {
  resPos.x = (position.x * 2.0) / resolution.x;
  resPos.y = (position.y * 2.0) / resolution.y;
  resPos.z = position.z;
  resPos.w = position.w;
  
  resPos.x -= 1.0;
  resPos.y -= 1.0;
  resPos.y = -resPos.y;
  
  /*u_matrix * */
  gl_Position = resPos;
 
  v_texcoord = texcoord;
}
""";

const _fragmentCode = r"""
#version 300 es
precision mediump float;

in vec2 v_texcoord;

uniform sampler2D u_texture;
 
out vec4 outColor;
 
void main() {
   outColor = texture(u_texture, v_texcoord);
}
""";
