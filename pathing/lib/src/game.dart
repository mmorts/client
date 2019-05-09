import 'package:pathing/pathing.dart';

import 'pathing.dart';
import 'movement/movement.dart';

import 'package:pathing/src/actor/unit.dart';
import 'package:pathing/src/actor/unmovable.dart';

export 'package:pathing/src/actor/unit.dart';

class Game {
  final map = TileMap(100, 100);

  final unmovables = <int, Unmovable>{};

  final units = <int, Unit>{};

  final movements = <int, Movement>{};

  int _time = 0;

  int get time => _time;

  Game();

  void start() {}

  void addUnit(Unit unit) {
    units[unit.id] = unit;
  }

  void addUnits(Iterable<Unit> units) {
    units.forEach((unit) => addUnit(unit));
  }

  void addMovement(Movement movement) {
    // TODO generate movement id
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
          throw Exception("Something is already on the tile ($posX:$posY) $owner");
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

  int _unitIdGen = 0;

  int get newUnitId => _unitIdGen++;
}

Map<int, Map<int, Unit>> splitUnitsByType(Iterable<Unit> units) {
  final fragileTypes = <int, Map<int, Unit>>{};
  for (Unit unit in units) {
    Map<int, Unit> type = fragileTypes[unit.stat.id];
    if (type == null) {
      type = <int, Unit>{};
      fragileTypes[unit.stat.id] = type;
    }
    type[unit.id] = unit;
  }
  return fragileTypes;
}
