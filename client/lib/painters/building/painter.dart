import 'dart:math';
import 'dart:web_gl';

import 'package:meta/meta.dart';

import 'package:ezwebgl/ezwebgl.dart';

import 'package:client/objects/objects.dart';

import 'package:loader/loader.dart';
import 'package:client/painters/sprite_repo.dart';

class BuildingPaintData {
  final List<SpriteRef> sprites;

  int previousTime;

  Position2 position;

  BuildingPaintData({this.sprites, this.previousTime: 0, this.position});
}

class BuildingPainter {
  final RenderingContext2 gl;

  final ShaderProgram shader;

  final Buffer buffer;

  BuildingPainter._({@required this.shader, @required this.buffer})
      : gl = shader.gl;

  void _paintSprite(State gameState, Rectangle rect, Texture texture) {
    // Set program
    shader.use();

    gl.bindTexture(WebGL.TEXTURE_2D, texture);

    var textureLocation = gl.getUniformLocation(shader.program, "u_texture");
    gl.uniform1i(textureLocation, 0);

    var resolutionLocation =
        gl.getUniformLocation(shader.program, "resolution");
    gl.uniform2f(resolutionLocation, gameState.size.x, gameState.size.y);

    shader.setUniformMatrix4fv("proj", gameState.projectionMatrix);

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

  void paint(BuildingPaintData p, {@required State gameState}) {
    int timeDiff = gameState.current - p.previousTime;
    for (SpriteRef sprite in p.sprites) {
      SpriteFrame frame;
      if (sprite.rate == 0) {
        frame = sprite.frames.first;
      } else {
        int framesPassed = (timeDiff ~/ sprite.rate);
        if (sprite.loop) {
          frame = sprite.frames[framesPassed % sprite.frames.length];
        } else {
          if (framesPassed < sprite.frames.length) {
            frame = sprite.frames[framesPassed];
          } else {
            frame = sprite.frames.last;
          }
        }
      }
      final newPos = p.position + sprite.offset;
      final rect = Rectangle(newPos.x, newPos.y, frame.size.x, frame.size.y);
      _paintSprite(gameState, rect, frame.texture);
    }
  }

  /*
  void paint(_PaintProps props, {@required State gameState}) {
    // Set program
    shader.use();

    gl.bindTexture(WebGL.TEXTURE_2D, textures[props.spriteId].texture);

    var textureLocation = gl.getUniformLocation(shader.program, "u_texture");
    gl.uniform1i(textureLocation, 0);

    var resolutionLocation =
        gl.getUniformLocation(shader.program, "resolution");
    gl.uniform2f(resolutionLocation, gameState.size.x, gameState.size.y);

    shader.setUniformMatrix4fv("proj", gameState.projectionMatrix);

    // Set data
    DataArray()
      ..add(PosTexBuf(
          position: Vec4(x: props.viewport.left, y: props.viewport.top),
          texCoords: Vec2(x: 0.0, y: 0.0)))
      ..add(PosTexBuf(
          position: Vec4(x: props.viewport.right, y: props.viewport.top),
          texCoords: Vec2(x: 1.0, y: 0.0)))
      ..add(PosTexBuf(
          position: Vec4(x: props.viewport.left, y: props.viewport.bottom),
          texCoords: Vec2(x: 0.0, y: 1.0)))
      ..add(PosTexBuf(
          position: Vec4(x: props.viewport.right, y: props.viewport.top),
          texCoords: Vec2(x: 1.0, y: 0.0)))
      ..add(PosTexBuf(
          position: Vec4(x: props.viewport.left, y: props.viewport.bottom),
          texCoords: Vec2(x: 0.0, y: 1.0)))
      ..add(PosTexBuf(
          position: Vec4(x: props.viewport.right, y: props.viewport.bottom),
          texCoords: Vec2(x: 1.0, y: 1.0)))
      ..drawArrays(gl: gl, buffer: buffer);
  }
  */

  static BuildingPainter make(RenderingContext2 gl) {
    ShaderProgram shader = ShaderProgram.prepare(
      gl: gl,
      vertex: _vertexCode,
      fragment: _fragmentCode,
    );

    Buffer buffer = PosTexBuf.createBuffer(shader);

    return BuildingPainter._(shader: shader, buffer: buffer);
  }
}

const _vertexCode = r"""
#version 300 es

in vec4 position;

in vec2 texcoord;

out vec2 v_texcoord;

uniform mat4 proj;
 
void main() {
  gl_Position = proj * position;
 
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
