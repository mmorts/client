import 'dart:async';
import 'dart:math';
import 'dart:web_gl';

import 'package:meta/meta.dart';

import 'package:jaguar_resty/jaguar_resty.dart' as resty;

import 'package:ezwebgl/ezwebgl.dart';

import 'package:client/objects/pos.dart';
import 'package:client/objects/state.dart';

import 'package:client/objects/military.dart';

import 'package:spec/graphics.dart' as spec;

import 'package:yaml/yaml.dart' as yaml;

import '../../objects/sprite.dart';

part 'texture.dart';

class MilitaryPainter {
  final RenderingContext2 gl;

  final ShaderProgram shader;

  final Buffer buffer;

  final MilitaryTextures textures;

  MilitaryPainter._(
      {@required this.shader, @required this.buffer, @required this.textures})
      : gl = shader.gl;

  void _paint(Point<double> pos, {UnitState unitState, State gameState}) {
    // Set program
    shader.use();

    Sprite sprite = textures.by(state: unitState.verb, dir: unitState.dir);

    final frameIndex =
        ((gameState.current - unitState.since) ~/ 150) % sprite.numFrames;

    final frame = sprite.frames[frameIndex];

    gl.bindTexture(WebGL.TEXTURE_2D, frame.texture);

    var textureLocation = gl.getUniformLocation(shader.program, "u_texture");
    gl.uniform1i(textureLocation, 0);

    var resolutionLocation =
        gl.getUniformLocation(shader.program, "resolution");
    gl.uniform2f(resolutionLocation, gameState.size.x, gameState.size.y);

    shader.setUniformMatrix4fv("proj", gameState.projectionMatrix);

    List<Vec2> texCords;
    if (shouldMirrorDir[unitState.dir]) {
      pos = Point<double>(
          pos.x - (frame.size.x - frame.hotspot.x), pos.y - frame.hotspot.y);
      texCords = [
        Vec2(x: 1.0, y: 0.0),
        Vec2(x: 0.0, y: 0.0),
        Vec2(x: 1.0, y: 1.0),
        Vec2(x: 0.0, y: 0.0),
        Vec2(x: 1.0, y: 1.0),
        Vec2(x: 0.0, y: 1.0),
      ];
    } else {
      pos = pos - frame.hotspot;
      texCords = [
        Vec2(x: 0.0, y: 0.0),
        Vec2(x: 1.0, y: 0.0),
        Vec2(x: 0.0, y: 1.0),
        Vec2(x: 1.0, y: 0.0),
        Vec2(x: 0.0, y: 1.0),
        Vec2(x: 1.0, y: 1.0),
      ];
    }

    final Rectangle<double> rect = Rectangle<double>(
        pos.x.toDouble(), pos.y.toDouble(), frame.size.x, frame.size.y);

    // Set data
    DataArray()
      ..add(PosTexBuf(
          position: Vec4(x: rect.left, y: rect.top), texCoords: texCords[0]))
      ..add(PosTexBuf(
          position: Vec4(x: rect.right, y: rect.top), texCoords: texCords[1]))
      ..add(PosTexBuf(
          position: Vec4(x: rect.left, y: rect.bottom), texCoords: texCords[2]))
      ..add(PosTexBuf(
          position: Vec4(x: rect.right, y: rect.top), texCoords: texCords[3]))
      ..add(PosTexBuf(
          position: Vec4(x: rect.left, y: rect.bottom), texCoords: texCords[4]))
      ..add(PosTexBuf(
          position: Vec4(x: rect.right, y: rect.bottom),
          texCoords: texCords[5]))
      ..drawArrays(gl: gl, buffer: buffer);
  }

  void paint(Military military, State gameState) {
    _paint(military.pos.toDoublePoint(),
        unitState: military.state, gameState: gameState);
  }

  static Future<MilitaryPainter> make(RenderingContext2 gl) async {
    ShaderProgram shader = ShaderProgram.prepare(
      gl: gl,
      vertex: _vertexCode,
      fragment: _fragmentCode,
    );

    Buffer buffer = PosTexBuf.createBuffer(shader);

    final textures =
        await MilitaryTextures.load(gl, "sprites/military/militia");

    return MilitaryPainter._(
        shader: shader, buffer: buffer, textures: textures);
  }
}

const shouldMirrorDir = {
  UnitDirection.s: false,
  UnitDirection.sw: false,
  UnitDirection.w: false,
  UnitDirection.nw: false,
  UnitDirection.n: false,
  UnitDirection.ne: true,
  UnitDirection.e: true,
  UnitDirection.se: true,
};

const directionMirror = {
  UnitDirection.ne: UnitDirection.nw,
  UnitDirection.e: UnitDirection.w,
  UnitDirection.se: UnitDirection.sw,
};

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
