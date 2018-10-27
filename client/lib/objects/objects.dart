
abstract class Visualization {
  int get visState;

  Map<int, List<Sprite>> get spriteSetMap;

  List<Sprite> get currentSpriteSet;
}

class Sprite {
  int width;

  int height;

  List<int> data;
}

class Position2 {
  double x;

  double y;

  Position2({this.x: 0.0, this.y: 0.0});
}

class Position3 implements Position2 {
  double x;

  double y;

  double z;

  Position3({this.x: 0.0, this.y: 0.0, this.z: 0.0});
}

class Paint {
  int width;

  int height;

  List<int> data;

  void draw(Position2 pos) {
    // TODO
  }
}