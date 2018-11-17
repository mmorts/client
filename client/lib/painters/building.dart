import 'dart:math';
import 'dart:async';
import 'dart:web_gl';

import 'package:meta/meta.dart';

import 'package:client/ezwebgl/ezwebgl.dart';

import 'package:client/objects/objects.dart';

BuildingPainter _painter;

class _PaintProps {
  final Rectangle rect;

  final int spriteId;

  _PaintProps({@required this.rect, @required this.spriteId});
}

class BuildingPainter {
  final RenderingContext2 gl;

  final ShaderProgram shader;

  final Buffer buffer;

  final Map<int, SizedTexture> textures;

  BuildingPainter._(
      {@required this.shader, @required this.buffer, @required this.textures})
      : gl = shader.gl;

  static Future<void> bootstrap(RenderingContext2 gl) async {
    ShaderProgram shader = ShaderProgram.prepare(
      gl: gl,
      vertex: _vertexCode,
      fragment: _fragmentCode,
    );

    Buffer buffer = PosTexBuf.createBuffer(shader);

    SizedTexture bambooTexture =
        await texFromUrl("sprites/building/bamboo/1.png", gl: gl);
    SizedTexture barrackTexture =
        await texFromUrl("sprites/building/barrack/1.png", gl: gl);

    _painter = BuildingPainter._(shader: shader, buffer: buffer, textures: {
      1: barrackTexture,
      2: bambooTexture,
    });
  }

  Point getSizeForSpriteId(int spriteId) {
    return textures[spriteId].size;
  }

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
          position: Vec4(x: props.rect.left, y: props.rect.top),
          texCoords: Vec2(x: 0.0, y: 0.0)))
      ..add(PosTexBuf(
          position: Vec4(x: props.rect.right, y: props.rect.top),
          texCoords: Vec2(x: 1.0, y: 0.0)))
      ..add(PosTexBuf(
          position: Vec4(x: props.rect.left, y: props.rect.bottom),
          texCoords: Vec2(x: 0.0, y: 1.0)))
      ..add(PosTexBuf(
          position: Vec4(x: props.rect.right, y: props.rect.top),
          texCoords: Vec2(x: 1.0, y: 0.0)))
      ..add(PosTexBuf(
          position: Vec4(x: props.rect.left, y: props.rect.bottom),
          texCoords: Vec2(x: 0.0, y: 1.0)))
      ..add(PosTexBuf(
          position: Vec4(x: props.rect.right, y: props.rect.bottom),
          texCoords: Vec2(x: 1.0, y: 1.0)))
      ..drawArrays(gl: gl, buffer: buffer);
  }
}

class Building {
  Position2 pos;

  Point<double> size = Point<double>(295.0, 207.0);

  int spriteId;

  Building({@required this.pos, @required this.size, @required this.spriteId}) {
    if (_painter == null) throw Exception("Building not bootstrapped!");
    size = _painter.getSizeForSpriteId(spriteId);
  }

  void paint(State gameState) {
    _painter.paint(
        _PaintProps(
            rect: Rectangle<double>(
              pos.x,
              pos.y - size.y + 22,
              size.x,
              size.y,
            ),
            spriteId: spriteId),
        gameState: gameState);
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
