part of 'movement.dart';

class NoFormationMovement implements Movement {
  final int id;
  final TileMap map;

  /// Units included in the formation
  final units = <int, UnitInMovement>{};

  final Position destination;

  NoFormationMovement(
      this.id, this.map, this.destination, Iterable<MovableWrap> units) {
    for (MovableWrap unit in units) {
      if (unit.movement != null) {
        unit.movement.removeUnit(unit);
      }
      unit.movement = this;

      this.units[unit.id] = UnitInMovement(unit);
    }

    recomputeAllPaths();
  }

  bool _finished = false;

  bool get finished => _finished;

  void recomputeAllPaths() {
    for (final unit in units.values) {
      unit.path =
          map.findPath(unit.unit.pos, destination, TerrainType.land)?.child;
      // TODO get to closest point.
    }
  }

  void recomputeUnitPath(UnitInMovement unit) {
    unit.path =
        map.findPath(unit.unit.pos, destination, TerrainType.land)?.child;
    // TODO get to closest point.
  }

  void tick() {
    bool allFinished = true;
    for (final unit in units.values) {
      if (unit.path == null) continue;

      Tile next = map.tiles[unit.path.tile.flatPos];
      // TODO if diagonal check we have space on sides
      if (!next.isWalkableBy(TerrainType.land)) {
        if (next.owner is Movable) {
          final obs = next.owner;
          // TODO if it has been a while recompute path
          // TODO if it is close enough, end movement
          if (units.containsKey(obs.id)) continue;
        }
        recomputeUnitPath(unit);
        // TODO what if new path is null
        next = map.tiles[unit.path.tile.flatPos];
      }

      Tile present = map.tileAt(unit.unit.pos);
      present.owner = null;
      next.owner = unit.unit;

      unit.unit.pos.copy(next.pos);
      unit.path = unit.path.child;
      if (unit.path != null) {
        allFinished = false;
      }
    }
    if (allFinished) _finished = true;
  }

  /// Removed units from this formation
  void removeUnit(MovableWrap unit) {
    units.remove(unit.id);
    unit.movement = null;
    recomputeAllPaths();
  }

  void dispose() {
    for (final unit in units.values) {
      unit.unit.movement = null;
    }
  }
}
