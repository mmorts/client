import 'package:pathing/pathing.dart';

import 'pathing.dart';
import 'movement/movement.dart';

import 'package:pathing/src/actor/movable.dart';
import 'package:pathing/src/actor/unmovable.dart';

export 'package:pathing/src/actor/movable.dart';

import 'actor/internal.dart';

class Pather {
  final map = TileMap(100, 100);

  final unmovables = <int, Unmovable>{};

  final movable = <int, MovableWrap>{};

  final movements = <int, Movement>{};

  int _time = 0;

  int get time => _time;

  Pather();

  void start() {}

  void addMovable(Movable unit) {
    movable[unit.id] = MovableWrap(unit);
  }

  void addMovables(Iterable<Movable> movabs) {
    movabs.forEach((unit) => addMovable(unit));
  }

  void addMovementWithFormation(Position to, Iterable<int> unitIds,
      {Formation formation}) {
    final units = <MovableWrap>[];

    for (int id in unitIds) {
      final wrap = movable[id];
      if (wrap == null) {
        continue;
        // throw "Unit is not in the books!";
      }
      units.add(wrap);
    }

    Movement movement;
    if (formation != null) {
      movement = MovementWithFormation(_moveIdGen++, this, to, units,
          formation: formation);
    } else {
      movement = NoFormationMovement(_moveIdGen++, map, to, units);
    }
    movements[movement.id] = movement;
  }

  void addUnmovable(Unmovable unmovable) {
    unmovables[unmovable.id] = unmovable;

    for (int x = 0; x < unmovable.stat.size.x; x++) {
      for (int y = 0; y < unmovable.stat.size.y; y++) {
        final posX = unmovable.pos.x + x;
        final posY = unmovable.pos.y + y;

        Tile tile = map.tileAt(Position(x: posX, y: posY));
        final owner = tile.owner;
        if (owner != null) {
          throw Exception(
              "Something is already on the tile ($posX:$posY) $owner");
        }

        tile.owner = unmovable;
      }
    }
  }

  void removeUnmovable(int id) {
    final Unmovable unmovable = unmovables.remove(id);
    if (unmovable == null) return;

    for (int x = 0; x < unmovable.stat.size.x; x++) {
      for (int y = 0; y < unmovable.stat.size.y; y++) {
        Tile tile = map.tileAt(Position(x: x, y: y));
        final owner = tile.owner;
        if (owner != unmovable) {
          // TODO throw
        }

        tile.owner = null;
      }
    }
  }

  void compute() {
    _time += 5;
    {
      final finished = <int>[];
      for (Movement movement in movements.values) {
        movement.tick();
        if (movement.finished) {
          movement.dispose();
          finished.add(movement.id);
        }
      }

      for (int finish in finished) {
        movements.remove(finish);
      }
    }
    // TODO
  }

  int _moveIdGen = 0;
}

Map<int, Map<int, MovableWrap>> splitUnitsByType(Iterable<MovableWrap> units) {
  final fragileTypes = <int, Map<int, MovableWrap>>{};
  for (MovableWrap unit in units) {
    Map<int, MovableWrap> type = fragileTypes[unit.stat.id];
    if (type == null) {
      type = <int, MovableWrap>{};
      fragileTypes[unit.stat.id] = type;
    }
    type[unit.id] = unit;
  }
  return fragileTypes;
}
