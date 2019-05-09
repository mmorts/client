import 'dart:math';
import 'dart:web_gl';
import 'package:meta/meta.dart';
import 'package:spec/graphics.dart' as spec;
import 'package:yaml/yaml.dart';
import 'package:image/image.dart' as img;

import 'io.dart';

import 'package:loader/model/model.dart';

class GameSpec {
  final Io io;

  final sprites = <String, Sprite>{};

  final buildingGraphics = <String, Building>{};

  GameSpec({ @required this.io});

  /*
  Future<Sprite> loadSprite(String name) async {
    final sps = Sprite.decode(loadYaml(
        String.fromCharCodes(await io.readSpriteFile(name, "spr.yaml"))));

    final frames = List<Frame>(sps.numFrames());

    for (int i = 0; i < sps.numFrames(); i++) {
      img.Image image =
          img.decodePng(await io.readSpriteFile(name, "${i + 1}.png"));
      frames[i] = Frame(
          index: i,
          image: image.getBytes(),
          size: Point<double>(image.width.toDouble(), image.height.toDouble()),
          hotspot: sps.frames[i].hotspot);
    }
    return Sprite(frames: frames);
  }

  Future<void> loadBuilding(String name) async {
    final spec = Building.decode(
        loadYaml(String.fromCharCodes(await io.readBuildingGraphicFile(name))));
    // TODO
  }
  */
}
