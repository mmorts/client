import 'dart:math';

class Resources {
  int wood;

  int food;

  int gold;

  int stone;
}

class FrameInfo {
  Point<int> hotspot;
}

class FrameSet {
  List<FrameInfo> frames;
}

class UnitSprite {
  FrameSet s;

  FrameSet sw;

  FrameSet w;

  FrameSet nw;

  FrameSet n;
}

class UnitStats {
  Resources cost;

  int hitPoints;

  int armor;

  int pierceArmor;

  Point<double> size;

  Point<double> selectionSize;
}

class BuildingSprite {
  Point<double> size;

  Point<double> selectionSize;


}