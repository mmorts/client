import 'dart:math';
import 'package:pathing/src/geom.dart';
import 'pathing.dart';
import 'movement.dart';

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

class Unit {
  final int id;
  final UnitStat stat;
  Player player;
  Position pos;
  Movement formation;

  Unit(this.id, this.stat, {this.player, this.pos, this.formation});
}

final militia = UnitStat(1,
    distance: Point<int>(1, 1), formationRole: FormationRole.protector);

class Player {
  final int id;
  final Game game;
  final units = <int, Unit>{};
  final buildings = <int, dynamic>{};
  final formations = <int, Movement>{};

  Player(this.id, this.game);

  Unit addUnit({Position pos}) {
    Unit unit = Unit(game.newUnitId, militia, player: this, pos: pos.clone());
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

  DateTime _startTime;

  Game();

  void start() {
    _startTime = DateTime.now();
  }

  void compute() {
    for (Player player in players.values) {
      final finished = <int>[];
      for (Movement formation in player.formations.values) {
        formation.tick();
        if (formation.finished) {
          formation.dispose();
          finished.add(formation.id);
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
