import 'dart:math';

class Resources {
  int wood;

  int food;

  int gold;

  int stone;
}

class Frame {
  String path;

  Point<int> hotspot;
}

class FrameAnimation {
  List<Frame> frames;
}

class UnitSprite {
  FrameAnimation s;

  FrameAnimation sw;

  FrameAnimation w;

  FrameAnimation nw;

  FrameAnimation n;
}

class UnitStats {
  Resources cost;

  int hitPoints;

  int armor;

  int pierceArmor;


}