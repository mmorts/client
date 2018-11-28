import 'geom.dart';
import 'pathing.dart';
import 'unit.dart';

class UnitInMovement {
  final int id;

  final Unit unit;

  Path path;

  // TODO speed

  UnitInMovement(Unit unit)
      : id = unit.id,
        unit = unit;
}

class Movement {
  final int id;
  final TileMap map;

  /// Units included in the formation
  final units = <int, UnitInMovement>{};

  final Position destination;

  Movement(this.id, this.map, this.destination, List<Unit> units) {
    for (Unit unit in units) {
      if (unit.formation != null) {
        unit.formation.removeUnit(unit);
      }
      unit.formation = this;

      this.units[unit.id] = UnitInMovement(unit)
        ..path = map.findPath(unit.pos, destination, TerrainType.land).child;
    }
  }

  bool _finished = false;

  bool get finished => _finished;

  void recomputeAllPaths() {
    for (final unit in units.values) {
      unit.path =
          map.findPath(unit.unit.pos, destination, TerrainType.land).child;
    }
  }

  void recomputeUnitPath(UnitInMovement unit) {
    unit.path =
        map.findPath(unit.unit.pos, destination, TerrainType.land).child;
  }

  void tick() {
    bool allFinished = true;
    for (final unit in units.values) {
      if (unit.path == null) continue;

      Tile next = map.tiles[unit.path.tile.flatPos];
      // TODO if diagonal check we have space on sides
      if (!next.isWalkableBy(TerrainType.land)) {
        if (next.owner is Unit) {
          final obs = next.owner;
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
  void removeUnit(Unit unit) {
    units.remove(unit.id);
    unit.formation = null;
    recomputeAllPaths();
  }

  void dispose() {
    for (final unit in units.values) {
      unit.unit.formation = null;
    }
  }
}
