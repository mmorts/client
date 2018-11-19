import 'dart:math';
import 'dart:web_gl';
import 'package:meta/meta.dart';
import 'package:client/spec/sprite.dart';
import 'package:yaml/yaml.dart';
import 'package:image/image.dart' as img;
import 'package:client/ezwebgl/ezwebgl.dart';

abstract class Io {
  Future<List<int>> readSpriteFile(String sprite, String file);
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

Future<Sprite> loadSprite(RenderingContext2 gl, Io io, String sprite,
    {double rate}) async {
  final sps = SpriteSpec.decode(loadYaml(
      String.fromCharCodes(await io.readSpriteFile(sprite, "spr.yaml"))));

  final frames = List<Frame>(sps.numFrames);

  for (int i = 0; i < sps.numFrames; i++) {
    img.Image image =
        img.decodePng(await io.readSpriteFile(sprite, "${i + 1}.png"));
    Texture texture = texFromImage(image, gl: gl);
    frames[i] = Frame(
        index: i,
        texture: texture,
        size: Point<double>(image.width.toDouble(), image.height.toDouble()),
        hotspot: sps.hotspot[i]);
  }
  return Sprite(frames: frames, rate: rate ?? sps.rate);
}
