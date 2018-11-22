import 'dart:math';
import 'dart:web_gl';
import 'package:meta/meta.dart';
import 'package:spec/spec.dart';
import 'package:yaml/yaml.dart';
import 'package:image/image.dart' as img;
import 'package:ezwebgl/ezwebgl.dart';

import 'io.dart';

import 'package:loader/model/model.dart';

class GameSpec {
  final RenderingContext2 gl;

  final Io io;

  final sprites = <String, Sprite>{};

  final buildingGraphics = <String, BuildingGraphicsSpec>{};

  GameSpec({@required this.gl, @required this.io});

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
