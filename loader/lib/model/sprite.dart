import 'dart:math';
import 'dart:web_gl';
import 'package:meta/meta.dart';

class Frame {
  final int index;

  dynamic /* List<int> | Texture */ image;

  final Point<double> size;

  final Point<int> hotspot;

  Frame(
      {@required this.index,
      @required this.image,
      @required this.size,
      @required this.hotspot});
}

class Sprite {
  final List<Frame> frames;

  final int length;

  Sprite(List<Frame> frames)
      : frames = frames,
        length = frames.length;
}

class Graphic {
  final Sprite sprite;

  final Point<int> offset;

  final int rate;

  final bool loop;

  Graphic({this.sprite, this.offset, this.rate, this.loop});

  List<Frame> get frames => sprite.frames;
}
