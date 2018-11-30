import 'dart:math';
import 'package:pathing/src/geom.dart';
import 'pathing.dart';
import 'movement/movement.dart';

enum FormationRole {
  fragile,
  protector,
}

class UnitStat {
  final int id;

  final Point<int> distance;

  final FormationRole formationRole;

  UnitStat(this.id, {this.distance, this.formationRole});
}

class Stats {
  final Map<int, UnitStat> units;

  Stats({this.units});
}

class Unit {
  final int id;
  final UnitStat stat;
  Player player;
  Position pos;
  Movement movement;

  Unit(this.id, this.stat, {this.player, this.pos, this.movement});
}

class Player {
  final int id;
  final Game game;
  final units = <int, Unit>{};
  final buildings = <int, dynamic>{};
  final formations = <int, Movement>{};

  Player(this.id, this.game);

  Unit addUnit(int unitTypeId, {Position pos}) {
    Unit unit = Unit(game.newUnitId, game.stats.units[unitTypeId],
        player: this, pos: pos.clone());
    units[unit.id] = unit;
    game.units[unit.id] = unit;
    return unit;
  }
}

class Game {
  final map = TileMap(100, 100);
  final players = <int, Player>{};
  final buildings = <int, dynamic>{};
  final units = <int, Unit>{};
  final Stats stats;

  DateTime _startTime;

  Game(this.stats);

  void start() {
    _startTime = DateTime.now();
  }

  void compute() {
    for (Player player in players.values) {
      final finished = <int>[];
      for (Movement movement in player.formations.values) {
        movement.tick();
        if (movement.finished) {
          movement.dispose();
          finished.add(movement.id);
        }
      }
      for (int finish in finished) {
        player.formations.remove(finish);
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
