part of 'movement.dart';

class MovementWithFormation implements Movement {
  final int id;
  final Game game;
  TileMap get map => game.map;

  /// Units included in the formation
  final units = <int, UnitInMovement>{};

  Map<int, Map<int, Unit>> _unitsByType;

  FormationMaker formation;

  final Position destination;

  MovementWithFormation(
      this.id, this.game, this.destination, Iterable<Unit> units,
      {this.formation}) {
    _unitsByType = splitUnitsByType(units);

    for (Unit unit in units) {
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

  FormationResult _formationResult;

  UnitInMovement _reference;

  /*
  void _computeReference() {
    _reference = units.values.first;

    {
      double bestDistance = _reference.unit.pos.distanceTo(destination);
      for (final unit in units.values) {
        final unitDist = unit.unit.pos.distanceTo(destination);
        if (unitDist < bestDistance) {
          _reference = unit;
          bestDistance = unitDist;
        }
      }
    }
  }
  */

  void _computeReference() {
    _reference =
        units[_unitsByType[_formationResult.reference.unitType].keys.first];
    double distance = _reference.unit.pos.distanceTo(destination);
    for (final unit
        in _unitsByType[_formationResult.reference.unitType].values) {
      final unitDis = unit.pos.distanceTo(destination);
      if (unitDis < distance) {
        _reference = units[unit.id];
        distance = unitDis;
      }
    }
  }

  // TODO move unitTypeMap here

  void recomputeAllPaths() {
    _formationResult =
        formation.format(_unitsByType, Point<int>(5, 100), game.stats.units);
    _computeReference();

    _reference.spot = _formationResult.reference;
    _formationResult.reference.unit = _reference.unit;
    _reference.path =
        map.findPath(_reference.unit.pos, destination, TerrainType.land)?.child;
    // TODO what if path is null?

    // TODO also use direction
    _formationResult.transform(_reference.unit.pos);

    for (final unit in units.values) {
      if (unit == _reference) continue;
      FormationSpot spot = _formationResult.getFreeSpotFor(unit.unit.stat.id);
      spot.unit = unit.unit;
      unit.spot = spot;
      unit.path = map
          .findPath(unit.unit.pos, spot.transformedSpot, TerrainType.land)
          ?.child;
      // TODO get to closest point.
    }
  }

  void recomputeUnitPath(UnitInMovement unit) {
    unit.path = map
        .findPath(unit.unit.pos, unit.spot.transformedSpot, TerrainType.land)
        ?.child;
    // TODO get to closest point.
  }

  void tick() {
    if (units.isEmpty) {
      _finished = true;
      return;
    }

    while (_reference.path != null) {
      Tile next = map.tiles[_reference.path.tile.flatPos];
      // TODO if diagonal check we have space on sides
      if (!next.isWalkableBy(TerrainType.land)) {
        if (next.owner is Unit) {
          // TODO can we do better?
          final obs = next.owner;
          if (units.containsKey(obs.id)) break;
        }
        // Obstacle! Recompute the whole path
        recomputeAllPaths();
        // TODO what if new path is null
        next = map.tiles[_reference.path.tile.flatPos];
      }

      Tile present = map.tileAt(_reference.unit.pos);
      present.owner = null;
      next.owner = _reference.unit;

      _reference.unit.pos.copy(next.pos);
      _reference.path = _reference.path.child;
      if (_reference.path != null) {
        // allFinished = false;
      }
      break;
    }

    _formationResult.transform(_reference.unit.pos);

    for (final unit in units.values) {
      if (unit != _reference) {
        if (unit.path == null) {
          // TODO check if we have reached the destination
          // TODO what if this is null?
        }
        recomputeUnitPath(unit);
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
          // allFinished = false;
        }
      }
    }
    // if (allFinished) _finished = true;
  }

  /// Removed units from this formation
  void removeUnit(Unit unit) {
    units.remove(unit.id);
    _unitsByType[unit.stat.id].remove(unit.id);
    if (_unitsByType[unit.stat.id].isEmpty) _unitsByType.remove(unit.stat.id);
    unit.movement = null;
    if (units.isNotEmpty) {
      recomputeAllPaths();
    }
  }

  void dispose() {
    for (final unit in units.values) {
      unit.unit.movement = null;
    }
  }
}
