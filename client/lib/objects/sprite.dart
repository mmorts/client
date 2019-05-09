import 'package:meta/meta.dart';

import 'dart:web_gl';
import 'dart:math';

class Frame {
  final Texture texture;

  final Point<double> size;

  final Point<double> hotspot;

  Frame({@required this.texture, @required this.size, @required this.hotspot});
}

class Sprite {
  final List<Frame> frames;

  Sprite(this.frames);

  int get numFrames => frames.length;
}
