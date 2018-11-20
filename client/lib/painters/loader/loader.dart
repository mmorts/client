import 'dart:math';
import 'dart:web_gl';
import 'package:meta/meta.dart';
import 'package:client/spec/sprite.dart';
import 'package:yaml/yaml.dart';
import 'package:image/image.dart' as img;
import 'package:client/ezwebgl/ezwebgl.dart';

abstract class Io {
  Future<List<int>> readSpriteFile(String name, String file);
  Future<List<int>> readBuildingGraphicFile(String name);
}

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

  final double rate;

  Sprite({@required this.frames, @required this.rate});
}

class SpriteRef {
  final Sprite sprite;

  final Point<int> offset;

  SpriteRef({this.sprite, this.offset});
}

class BuildingLayer {
  final int depth;

  final List<SpriteRef> sprites;

  BuildingLayer({this.depth, this.sprites});
}

class BuildingGraphics {
  // TODO add others

  final List<BuildingLayer> standing;

  BuildingGraphics({this.standing});
}

class GameAsset {
  final RenderingContext2 gl;

  final Io io;

  final sprites = <String, Sprite>{};

  GameAsset({@required this.gl, @required this.io});

  Future<Sprite> loadSprite(String name) async {
    final sps = SpriteSpec.decode(loadYaml(
        String.fromCharCodes(await io.readSpriteFile(name, "spr.yaml"))));

    final frames = List<Frame>(sps.numFrames);

    for (int i = 0; i < sps.numFrames; i++) {
      img.Image image =
          img.decodePng(await io.readSpriteFile(name, "${i + 1}.png"));
      Texture texture = texFromImage(image, gl: gl);
      frames[i] = Frame(
          index: i,
          texture: texture,
          size: Point<double>(image.width.toDouble(), image.height.toDouble()),
          hotspot: sps.hotspot[i]);
    }
    return Sprite(frames: frames);
  }

  Future<BuildingGraphics> loadBuilding(String name) async {
    await io.readBuildingGraphicFile(name);
    // TODO
  }
}
