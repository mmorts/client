import 'package:meta/meta.dart';
import 'package:protocol/src/objects/unit.dart';
import 'package:protocol/src/spatial/tile.dart';
import 'package:protocol/src/cmd/cmd.dart';

import 'package:pathing/pathing.dart';

// import 'package:spec/stats.dart';

class Controller {
  DateTime _startTime;
  int _curTick = 0;

  final List<Tile> tiles;

  final Map<int, Movable> units;

  final Pather pather;

  Controller(
      {@required this.tiles, @required this.units, @required this.pather});

  void start() {
    _startTime = DateTime.now();
    // TODO set things in motion
  }

  void processTick() {
    // TODO implement pausing the game
    _curTick = DateTime.now().difference(_startTime).inMilliseconds;

    // TODO
  }

  String addMoveUnit(/* TODO Player player, */ MoveUnits cmd) {
    // Collect all units
    final units = <int, Movable>{};
    for (final id in cmd.unitId) {
      final unit = this.units[id];
      if (unit == null) continue;
      // TODO check if the unit belongs to the player

      units[id] = this.units[id];
    }

    // TODO remove from other formation

    // TODO put into formation

    // TODO Compute pathing

    // TODO set the move task

    // TODO
  }
}
