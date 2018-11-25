class Position {
  int x;

  int y;

  Position({this.x: 0, this.y: 0});

  Position get north => Position(x: x, y: y - 1);

  Position get south => Position(x: x, y: y + 1);

  Position get east => Position(x: x + 1, y: y);

  Position get west => Position(x: x - 1, y: y);

  Position get northEast => Position(x: x + 1, y: y - 1);

  Position get southEast => Position(x: x + 1, y: y + 1);

  Position get northWest => Position(x: x - 1, y: y - 1);

  Position get southWest => Position(x: x - 1, y: y + 1);

  List<Position> get neighbours => [north, northEast, east, southEast, south, southWest, west, northWest];

  bool get hasNegative => x.isNegative || y.isNegative;
}

class Tile {
  Position pos;
}

class TileMap {
  final int width = 20;
  final int height = 20;
  final tiles = <int, Tile>{};

  List<Tile> getNeighbours(Position pos) {
    for(Position point in pos.neighbours) {
      if(point.hasNegative) continue;
      if(point.x >= width) continue;
      if(point.y >= height) continue;

      // TODO
    }
  }

  void findPath(Position start, Position goal) {
    // TODO
  }
}
