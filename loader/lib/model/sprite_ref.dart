import 'dart:math';
import 'dart:web_gl';
import 'package:meta/meta.dart';

class SpriteFrame {
  final int index;

  final List<int> image;

  final Point<double> size;

  final Point hotspot;

  SpriteFrame(
      {@required this.index,
      @required this.image,
      @required this.size,
      @required this.hotspot});
}

class Sprite {
  final List<SpriteFrame> frames;

  final int length;

  Sprite({@required List<SpriteFrame> frames})
      : frames = frames,
        length = frames.length;
}

class SpriteRef {
  final Sprite sprite;

  final Point<int> offset;

  final int rate;

  final bool loop;

  SpriteRef({this.sprite, this.offset, this.rate, this.loop});

  List<SpriteFrame> get frames => sprite.frames;
}
