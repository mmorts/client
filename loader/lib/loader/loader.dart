import 'dart:math';
import 'dart:web_gl';
import 'package:meta/meta.dart';
import 'package:spec/spec.dart';
import 'package:yaml/yaml.dart';
import 'package:image/image.dart' as img;
import 'package:ezwebgl/ezwebgl.dart';

import 'io.dart';

class Frame {
  final int index;

  final Texture texture;

  final Point<double> size;

  final Point hotspot;

  Frame(
      {@required this.index,
      @required this.texture,
      @required this.size,
      @required this.hotspot});
}

class Sprite {
  final List<Frame> frames;

  final int length;

  Sprite({@required List<Frame> frames})
      : frames = frames,
        length = frames.length;
}

class GameAsset {
  final RenderingContext2 gl;

  final Io io;

  final sprites = <String, Sprite>{};

  GameAsset({@required this.gl, @required this.io});

  Future<Sprite> loadSprite(String name) async {
    final sps = SpriteSpec.decode(loadYaml(
        String.fromCharCodes(await io.readSpriteFile(name, "spr.yaml"))));

    final frames = List<Frame>(sps.numFrames());

    for (int i = 0; i < sps.numFrames(); i++) {
      img.Image image =
          img.decodePng(await io.readSpriteFile(name, "${i + 1}.png"));
      Texture texture = texFromImage(image, gl: gl);
      frames[i] = Frame(
          index: i,
          texture: texture,
          size: Point<double>(image.width.toDouble(), image.height.toDouble()),
          hotspot: sps.frames[i].hotspot);
    }
    return Sprite(frames: frames);
  }

  Future<void> loadBuilding(String name) async {
    final spec = BuildingGraphicsSpec.decode(
        loadYaml(String.fromCharCodes(await io.readBuildingGraphicFile(name))));
    // TODO
  }
}

class SpriteRef {
  final Sprite sprite;

  final Point<int> offset;

  final int rate;

  final bool loop;

  SpriteRef({this.sprite, this.offset, this.rate, this.loop});

  List<Frame> get frames => sprite.frames;
}
