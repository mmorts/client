import 'dart:async';
import 'dart:math';
import 'dart:web_gl';

import 'package:meta/meta.dart';

import 'package:jaguar_resty/jaguar_resty.dart' as resty;

import 'package:ezwebgl/ezwebgl.dart';

import 'package:client/objects/pos.dart';
import 'package:client/objects/state.dart';

import 'package:client/objects/military.dart';

class MilitaryDirTextures {
  final Iterable<Texture> s;
  final Iterable<Texture> sw;
  final Iterable<Texture> w;
  final Iterable<Texture> nw;
  final Iterable<Texture> n;

  MilitaryDirTextures({this.s, this.sw, this.w, this.nw, this.n});

  Iterable<Texture> byDir(UnitDirection dir) {
    switch (dir) {
      case UnitDirection.s:
        return s;
      case UnitDirection.sw:
      case UnitDirection.se:
        return sw;
      case UnitDirection.w:
      case UnitDirection.e:
        return w;
      case UnitDirection.nw:
      case UnitDirection.ne:
        return nw;
      case UnitDirection.n:
        return n;
      default:
        return s;
    }
  }

  static Future<MilitaryDirTextures> load(
      RenderingContext2 gl, String path) async {
    List<Texture> w = await loadOneDir(gl, path + "/w");
    List<Texture> s = await loadOneDir(gl, path + "/s");
    List<Texture> n = await loadOneDir(gl, path + "/n");
    List<Texture> nw = await loadOneDir(gl, path + "/nw");
    List<Texture> sw = await loadOneDir(gl, path + "/sw");

    return MilitaryDirTextures(
      w: w,
      s: s,
      n: n,
      nw: nw,
      sw: sw,
    );
  }

  static Future<List<Texture>> loadOneDir(
      RenderingContext2 gl, String path) async {
    final ret = <Texture>[];

    resty.StringResponse resp;
    int frameCount = 1;
    do {
      resp = await resty.get(path + "/$frameCount.png").go();
      if (resp.statusCode != 404) {
        ret.add(texFromBytes(resp.bytes, gl: gl).texture);
      }
      frameCount++;
    } while (resp.statusCode != 404);

    if (ret.isEmpty) throw Exception("No frames found!");

    return ret;
  }
}

class MilitaryTextures {
  final MilitaryDirTextures stand;

  final MilitaryDirTextures walk;

  final MilitaryDirTextures attack;

  final MilitaryDirTextures die;

  final MilitaryDirTextures rot;

  MilitaryTextures({this.stand, this.walk, this.attack, this.die, this.rot});

  Iterable<Texture> by({UnitVerb state, UnitDirection dir}) {
    switch (state) {
      case UnitVerb.stand:
        return stand.byDir(dir);
      case UnitVerb.walk:
        return walk.byDir(dir);
      case UnitVerb.attack:
        return attack.byDir(dir);
      case UnitVerb.die:
        return die.byDir(dir);
      case UnitVerb.rot:
        return rot.byDir(dir);
      default:
        return stand.byDir(dir);
    }
  }

  static Future<MilitaryTextures> load(
      RenderingContext2 gl, String path) async {
    final stand = await MilitaryDirTextures.load(gl, path + "/stand");
    // final walk = await MilitaryDirTextures.load(gl, path + "/walk");
    return MilitaryTextures(
      stand: stand, /* walk: walk */
    );
  }
}

class MilitaryPainter {
  final RenderingContext2 gl;

  final ShaderProgram shader;

  final Buffer buffer;

  final MilitaryTextures textures;

  MilitaryPainter._(
      {@required this.shader, @required this.buffer, @required this.textures})
      : gl = shader.gl;

  void _paint(Rectangle rect, {UnitState unitState, State gameState}) {
    // Set program
    shader.use();

    Iterable<Texture> texs =
        textures.by(state: unitState.verb, dir: unitState.dir);
    if (shouldMirrorDir[unitState.dir]) {
      // TODO mirror
    }

    final frame = ((gameState.current - unitState.since) ~/ 150) % texs.length;

    gl.bindTexture(WebGL.TEXTURE_2D, texs.elementAt(frame));

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

  void paint(Military military, State gameState) {
    _paint(
        Rectangle<double>(
            military.pos.x, military.pos.y, military.size.x, military.size.y),
        unitState: military.state,
        gameState: gameState);
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
