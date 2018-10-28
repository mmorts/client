import 'dart:async';
import 'dart:web_gl';
import 'dart:math';
import 'dart:typed_data';

import 'package:meta/meta.dart';

import 'package:client/ezwebgl/ezwebgl.dart';

import 'package:client/objects/objects.dart';

TerrainPainter _painter;

class TerrainPainter {
  final RenderingContext2 gl;

  final ShaderProgram shader;

  final Buffer buffer;

  final Texture texture;

  TerrainPainter(
      {@required this.shader, @required this.buffer, @required this.texture})
      : gl = shader.gl;

  void paint(Rectangle rect, {State gameState}) {
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

  static Future<void> bootstrap(RenderingContext2 gl) async {
    ShaderProgram shader = ShaderProgram.prepare(
      gl: gl,
      vertex: _vertexCode,
      fragment: _fragmentCode,
    );

    Buffer buffer = PosTexBuf.createBuffer(shader);

    final texture = await texFromUrl("sprites/terrain/land.png", gl: gl);

    _painter = TerrainPainter(
      shader: shader,
      buffer: buffer,
      texture: texture,
    );
  }
}

class Terrain {
  Position2 position = Position2(x: 100.0, y: 100.0);

  Point<double> size = Point<double>(512.0, 512.0);

  Terrain() {
    if (_painter == null) throw Exception("TerrainPainter not bootstrapped!");
  }

  void paint(State gameState) {
    _painter.paint(Rectangle(position.x, position.y, size.x, size.y),
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

mat4 rot = mat4(vec4());
 
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
