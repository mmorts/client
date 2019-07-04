import 'dart:math';
import 'package:meta/meta.dart';

import 'package:pathing/src/geom.dart';
import '../movement/movement.dart';

import 'actor.dart';

enum FormationRole {
  fragile,
  protector,
}

abstract class Movable implements Actor {
  int get id;

  MovableStat get stat;

  int get clan;

  Position get pos;

  Movement movement;  // TODO
}

class MovableStat implements ActorStat {
  final int id;

  final Point<int> size;

  final FormationRole formationRole;

  int speed;

  MovableStat(this.id,
      {@required this.size,
      @required this.formationRole,
      @required this.speed});
}
