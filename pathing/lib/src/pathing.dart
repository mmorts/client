import 'package:meta/meta.dart';
import 'package:pathing/src/geom.dart';
import 'unit.dart';

abstract class TerrainType {
  static const land = 0x1;
  static const water = 0x2;
}

enum Direction {
  n,
  ne,
  e,
  se,
  s,
  sw,
  w,
  nw,
}

final dirToDistance = {
  Direction.n: 1.0,
  Direction.ne: 1.414,
  Direction.e: 1.0,
  Direction.se: 1.414,
  Direction.s: 1.0,
  Direction.sw: 1.414,
  Direction.w: 1.0,
  Direction.nw: 1.414,
};

class TileWithDirection {
  final Tile tile;

  final Direction dir;

  TileWithDirection({this.tile, this.dir});

  bool isWalkableBy(int type) => tile.isWalkableBy(type);

  double get distance => dirToDistance[dir];
}

class Tile {
  final int numHTiles;
  final int numVTiles;
  final Position pos;
  int terrainType;
  dynamic owner;

  Tile(
      {this.numHTiles,
      this.numVTiles,
      this.pos,
      this.terrainType: TerrainType.land});

  bool isWalkableBy(int type) {
    // TODO
    if (owner != null && owner is! Unit) return false;
    // if (owner != null) return false;
    return terrainType & type != 0;
  }

  int get flatPos => (pos.y * numHTiles) + pos.x;

  double fCostTo(Position start, Position end) {
    double g = start.distanceTo(pos);
    double h = end.distanceTo(pos);
    return g + h;
  }

  TileWithDirection _north;
  TileWithDirection get north => _north;

  TileWithDirection _northEast;
  TileWithDirection get northEast => _northEast;

  TileWithDirection _east;
  TileWithDirection get east => _east;

  TileWithDirection _southEast;
  TileWithDirection get southEast => _southEast;

  TileWithDirection _south;
  TileWithDirection get south => _south;

  TileWithDirection _southWest;
  TileWithDirection get southWest => _southWest;

  TileWithDirection _west;
  TileWithDirection get west => _west;

  TileWithDirection _northWest;
  TileWithDirection get northWest => _northWest;

  List<TileWithDirection> getWalkableNeighbours(int terrainType) {
    TileWithDirection north = this.north;
    TileWithDirection northEast = this.northEast;
    TileWithDirection east = this.east;
    TileWithDirection southEast = this.southEast;
    TileWithDirection south = this.south;
    TileWithDirection southWest = this.southWest;
    TileWithDirection west = this.west;
    TileWithDirection northWest = this.northWest;

    final ret = <TileWithDirection>[];

    if (north.tile != null && north.isWalkableBy(terrainType)) {
      ret.add(north);
    } else {
      north = null;
    }

    if (east.tile != null && east.isWalkableBy(terrainType)) {
      ret.add(east);
    } else {
      east = null;
    }

    if (south.tile != null && south.isWalkableBy(terrainType)) {
      ret.add(south);
    } else {
      south = null;
    }

    if (west.tile != null && west.isWalkableBy(terrainType)) {
      ret.add(west);
    } else {
      west = null;
    }

    if (northEast.tile != null &&
        north != null &&
        east != null &&
        northEast.isWalkableBy(terrainType)) {
      ret.add(northEast);
    }

    if (southEast.tile != null &&
        south != null &&
        east != null &&
        southEast.isWalkableBy(terrainType)) {
      ret.add(southEast);
    }

    if (southWest.tile != null &&
        south != null &&
        west != null &&
        southWest.isWalkableBy(terrainType)) {
      ret.add(southWest);
    }

    if (northWest.tile != null &&
        north != null &&
        west != null &&
        northWest.isWalkableBy(terrainType)) {
      ret.add(northWest);
    }

    return ret;
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
    for (int y = 0; y < numVTiles; y++) {
      for (int x = 0; x < numHTiles; x++) {
        final pos = Position(x: x, y: y);
        Tile tile = tiles[flatPosOf(pos)];
        tile._north =
            TileWithDirection(tile: _getTileAt(pos.north), dir: Direction.n);
        tile._northEast = TileWithDirection(
            tile: _getTileAt(pos.northEast), dir: Direction.ne);
        tile._east =
            TileWithDirection(tile: _getTileAt(pos.east), dir: Direction.e);
        tile._southEast = TileWithDirection(
            tile: _getTileAt(pos.southEast), dir: Direction.se);
        tile._south =
            TileWithDirection(tile: _getTileAt(pos.south), dir: Direction.s);
        tile._southWest = TileWithDirection(
            tile: _getTileAt(pos.southWest), dir: Direction.sw);
        tile._west =
            TileWithDirection(tile: _getTileAt(pos.west), dir: Direction.w);
        tile._northWest = TileWithDirection(
            tile: _getTileAt(pos.northWest), dir: Direction.nw);
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

  Path findPath(Position start, Position end, int terrainType) {
    final open = <int, _Path>{};
    final closed = <int, _Path>{};

    final endTile = _getTileAt(end);

    var current = _Path(null, _getTileAt(start),
        fcost: end.distanceTo(start),
        distanceFromStart: 0,
        distanceToEnd: end.distanceTo(start),
        dir: null,
        zigzagCost: 0);
    open[current.tile.flatPos] = current;

    do {
      current = open.values.first;
      for (_Path ct in open.values) {
        if (ct.fcost < current.fcost) {
          current = ct;
        }
      }
      open.remove(current.tile.flatPos);
      closed[current.tile.flatPos] = current;

      if (current.tile.flatPos == endTile.flatPos) {
        Path ret = Path(null, current.tile,
            fcost: current.fcost,
            distanceToEnd: current.distanceToEnd,
            dir: current.dir);
        while (current.parent != null) {
          current = current.parent;
          ret = Path(ret, current.tile,
              fcost: current.fcost,
              distanceToEnd: current.distanceToEnd,
              dir: current.dir);
        }
        return ret;
      }

      for (TileWithDirection neigh
          in current.tile.getWalkableNeighbours(terrainType)) {
        final Tile neighTile = neigh.tile;

        if (closed.containsKey(neighTile.flatPos)) continue;

        double zigzagCost = current.zigzagCost;
        final toEnd = end.distanceTo(neighTile.pos);
        if (current.dir != null && neigh.dir != current.dir) zigzagCost += 0.7;
        final toStart = current.distanceFromStart + neigh.distance + zigzagCost;
        double neighFCost = toStart + toEnd;
        final existingOpen = open[neighTile.flatPos];
        if (existingOpen == null || neighFCost <= existingOpen.fcost) {
          final newFind = _Path(current, neighTile,
              distanceFromStart: toStart,
              fcost: neighFCost,
              distanceToEnd: toEnd,
              dir: neigh.dir,
              zigzagCost: zigzagCost);
          open[neighTile.flatPos] = newFind;
        }
      }
    } while (open.isNotEmpty);

    return null;
  }

  int flatPosOf(Position pos) => (pos.y * numHTiles) + pos.x;

  Tile tileAt(Position pos) => tiles[flatPosOf(pos)];
}

class Path {
  final Path child;

  final Tile tile;

  final double distanceToEnd;

  final double fcost;

  final Direction dir;

  Path(this.child, this.tile,
      {@required this.fcost, @required this.distanceToEnd, @required this.dir});
}

class _Path {
  final _Path parent;

  final Tile tile;

  final double distanceFromStart;

  final double distanceToEnd;

  final double fcost;

  final Direction dir;

  final double zigzagCost;

  _Path(this.parent, this.tile,
      {@required this.distanceToEnd,
      @required this.distanceFromStart,
      @required this.fcost,
      @required this.dir,
      @required this.zigzagCost});

  String toString() {
    return "${tile.pos.x}:${tile.pos.y} -> $parent";
  }

  Path get toPath {
    _Path current = this;
    Path ret = Path(null, current.tile,
        fcost: current.fcost,
        distanceToEnd: current.distanceToEnd,
        dir: current.dir);
    while (current.parent != null) {
      current = current.parent;
      ret = Path(ret, current.tile,
          fcost: current.fcost,
          distanceToEnd: current.distanceToEnd,
          dir: current.dir);
    }
    return ret;
  }
}
