import 'dart:math';

class Sprite {
  String sprite;

  Point<int> offset;
}

class Layer {
  List<Sprite> sprites;
  int depth;
}

class BuildingGraphicsSpec {
  List<Layer> constructing;
  List<Layer> standing;
  List<Layer> garrison;
  List<Layer> dying;
  Map<int, List<Layer>> damage;
}