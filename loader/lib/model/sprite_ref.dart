import 'dart:math';
import 'dart:web_gl';
import 'package:meta/meta.dart';

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

class SpriteRef {
  final Sprite sprite;

  final Point<int> offset;

  final int rate;

  final bool loop;

  SpriteRef({this.sprite, this.offset, this.rate, this.loop});

  List<Frame> get frames => sprite.frames;
}
