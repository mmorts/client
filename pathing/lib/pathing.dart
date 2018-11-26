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
}

abstract class TerrainType {
  static const filled = 0x1;
  static const land = 0x2;
  static const water = 0x4;
}

class Tile {
  final int numHTiles;
  final int numVTiles;
  final Position pos;
  int terrainType;

  Tile(
      {this.numHTiles,
      this.numVTiles,
      this.pos,
      this.terrainType: TerrainType.land});

  bool isWalkableBy(int type) {
    if (terrainType & TerrainType.filled != 0) return false;
    return terrainType & type != 0;
  }

  int get flatPos => (pos.y * numHTiles) + pos.x;

  double fCostTo(Position start, Position end) {
    double g = start.distanceTo(pos);
    double h = end.distanceTo(pos);
    return g + h;
  }
}

class TileMap {
  final int numHTiles;
  final int numVTiles;
  final tiles = <int, Tile>{};

  TileMap(this.numHTiles, this.numVTiles) {
    for (int y = 0; y < numVTiles; y++) {
      for (int x = 0; x < numHTiles; x++) {
        final pos = Position(x: x, y: y);
        tiles[(y * numHTiles) + x] =
            Tile(numHTiles: numHTiles, numVTiles: numVTiles, pos: pos);
      }
    }
  }

  Tile _getTileAt(Position pos) {
    if (pos.hasNegative) return null;
    if (pos.x >= numHTiles) return null;
    if (pos.y >= numVTiles) return null;
    int flatPos = (pos.y * numHTiles) + pos.x;
    return tiles[flatPos];
  }

  List<Tile> getWalkableNeighbours(Position pos, int terrainType) {
    Tile north = _getTileAt(pos.north);
    Tile northEast = _getTileAt(pos.northEast);
    Tile east = _getTileAt(pos.east);
    Tile southEast = _getTileAt(pos.southEast);
    Tile south = _getTileAt(pos.south);
    Tile southWest = _getTileAt(pos.southWest);
    Tile west = _getTileAt(pos.west);
    Tile northWest = _getTileAt(pos.northWest);

    final ret = <Tile>[];

    if (north != null && north.isWalkableBy(terrainType)) {
      ret.add(north);
    } else {
      north = null;
    }

    if (east != null && east.isWalkableBy(terrainType)) {
      ret.add(east);
    } else {
      east = null;
    }

    if (south != null && south.isWalkableBy(terrainType)) {
      ret.add(south);
    } else {
      south = null;
    }

    if (west != null && west.isWalkableBy(terrainType)) {
      ret.add(west);
    } else {
      west = null;
    }

    if (northEast != null &&
        north != null &&
        east != null &&
        northEast.isWalkableBy(terrainType)) {
      ret.add(northEast);
    }

    if (southEast != null &&
        south != null &&
        east != null &&
        southEast.isWalkableBy(terrainType)) {
      ret.add(southEast);
    }

    if (southWest != null &&
        south != null &&
        west != null &&
        southWest.isWalkableBy(terrainType)) {
      ret.add(southWest);
    }

    if (northWest != null &&
        north != null &&
        west != null &&
        northWest.isWalkableBy(terrainType)) {
      ret.add(northWest);
    }

    return ret;
  }

  Path findPath(Position start, Position end, int terrainType) {
    final open = <int, Path>{};
    final closed = <int, Path>{};

    final endTile = _getTileAt(end);

    Path current = Path(null, _getTileAt(start), 0, end.distanceTo(start));
    open[current.tile.flatPos] = current;

    do {
      current = open.values.first;
      for (Path ct in open.values) {
        if (ct.fcost < current.fcost) {
          current = ct;
        }
      }
      open.remove(current.tile.flatPos);
      closed[current.tile.flatPos] = current;

      if (current.tile.flatPos == endTile.flatPos) {
        return current;
      }

      for (Tile neigh in getWalkableNeighbours(current.tile.pos, terrainType)) {
        if (closed.containsKey(neigh.flatPos)) continue;
        if (open.containsKey(neigh.flatPos)) continue;

        final distance =
            current.distance + current.tile.pos.distanceTo(neigh.pos);
        final neighFCost = distance + end.distanceTo(neigh.pos);
        final existing = open[neigh.flatPos];
        if (existing == null || neighFCost <= existing.fcost) {
          final newFind = Path(current, neigh, distance, neighFCost);
          open[neigh.flatPos] = newFind;
        }
      }
    } while (open.isNotEmpty);

    return null;
  }
}

class Path {
  final Path parent;

  final Tile tile;

  final double distance;

  final double fcost;

  Path(this.parent, this.tile, this.distance, this.fcost);

  String toString() {
    return "${tile.pos.x}:${tile.pos.y} -> $parent";
  }
}
