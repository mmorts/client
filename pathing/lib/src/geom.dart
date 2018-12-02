import 'dart:math';

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

  List<Position> get neighbours =>
      [north, northEast, east, southEast, south, southWest, west, northWest];

  bool get hasNegative => x.isNegative || y.isNegative;

  double distanceTo(Position other) {
    final xDiff = x - other.x;
    final yDiff = y - other.y;
    return sqrt(xDiff * xDiff + yDiff * yDiff);
  }

  void copy(Position other) {
    x = other.x;
    y = other.y;
  }

  Position clone() => Position(x: x, y: y);

  bool operator ==(other) {
    if (x == other.x && y == other.y) return true;
    return false;
  }

  @override
  int get hashCode => super.hashCode;

  Position operator *(Position other) =>
      Position(x: x * other.x, y: y * other.y);

  Position operator +(Position other) =>
      Position(x: x + other.x, y: y + other.y);

  Position macc(Position m, Position acc) =>
      Position(x: x * m.x + acc.x, y: y * m.y + acc.y);

  Position dot(Position other) => Position(x: x * other.x, y: y * other.y);
}

abstract class HasPosition {
  Position get pos;
}
