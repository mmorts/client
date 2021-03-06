import 'dart:async';
import 'dart:web_gl';
import 'dart:math';

import 'package:meta/meta.dart';

import 'package:ezwebgl/ezwebgl.dart';

import 'package:client/objects/pos.dart';
import 'package:client/objects/state.dart';

class TerrainPainter {
  final RenderingContext2 gl;

  final ShaderProgram shader;

  final Buffer buffer;

  final Texture texture;

  TerrainPainter(
      {@required this.shader, @required this.buffer, @required this.texture})
      : gl = shader.gl;

  void _paint(Rectangle rect, {State gameState}) {
    // Set program
    shader.use();

    gl.bindTexture(WebGL.TEXTURE_2D, texture);
    var textureLocation = gl.getUniformLocation(shader.program, "u_texture");
    gl.uniform1i(textureLocation, 0);

    final mat = isometricTransformation(rect);

    shader.setUniformMatrix4fv("model", mat);
    shader.setUniformMatrix4fv("proj", gameState.projectionMatrix);

    // Set data
    DataArray()
      ..add(PosTexBuf.coords(x: rect.left, y: rect.top, tx: 0.0, ty: 0.0))
      ..add(PosTexBuf.coords(x: rect.right, y: rect.top, tx: 1.0, ty: 0.0))
      ..add(PosTexBuf.coords(x: rect.left, y: rect.bottom, tx: 0.0, ty: 1.0))
      ..add(PosTexBuf.coords(x: rect.right, y: rect.top, tx: 1.0, ty: 0.0))
      ..add(PosTexBuf.coords(x: rect.left, y: rect.bottom, tx: 0.0, ty: 1.0))
      ..add(PosTexBuf.coords(x: rect.right, y: rect.bottom, tx: 1.0, ty: 1.0))
      ..drawArrays(gl: gl, buffer: buffer);
  }

  void paint(Terrain terrain, State gameState) {
    _paint(
        Rectangle(terrain.position.x, terrain.position.y, terrain.size.x,
            terrain.size.y),
        gameState: gameState);
  }

  static Future<TerrainPainter> make(RenderingContext2 gl) async {
    ShaderProgram shader = ShaderProgram.prepare(
      gl: gl,
      vertex: _vertexCode,
      fragment: _fragmentCode,
    );

    Buffer buffer = PosTexBuf.createBuffer(shader);

    final texture = await texFromUrl("sprites/terrain/land.png", gl: gl);

    return TerrainPainter(
      shader: shader,
      buffer: buffer,
      texture: texture.texture,
    );
  }
}

class Terrain {
  Position2 position = Position2(x: 0.0, y: 0.0);

  Point<double> size = Point<double>(512.0, 512.0);

  Terrain();
}

const _vertexCode = r"""
#version 300 es

in vec4 position;

in vec2 texcoord;

out vec2 v_texcoord;

uniform mat4 proj;

uniform mat4 model;
 
void main() {
  gl_Position = proj * model * position;
 
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
