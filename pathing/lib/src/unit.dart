import 'package:pathing/src/geom.dart';
import 'pathing.dart';
import 'movement.dart';

class Unit {
  final int id;
  Player player;
  Position pos;
  Movement formation;

  Unit(this.id, {this.player, this.pos, this.formation});
}

class Player {
  final int id;
  final Game game;
  final units = <int, Unit>{};
  final buildings = <int, dynamic>{};
  final formations = <int, Movement>{};

  Player(this.id, this.game);

  Unit addUnit({Position pos}) {
    Unit unit = Unit(game.newUnitId, player: this, pos: pos.clone());
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
