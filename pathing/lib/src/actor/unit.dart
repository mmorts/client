import 'dart:math';
import 'package:meta/meta.dart';

import 'package:pathing/src/geom.dart';
import '../movement/movement.dart';

import 'actor.dart';

enum FormationRole {
  fragile,
  protector,
}

class Unit implements Actor {
  final int id;

  UnitStat stat;

  int clan;

  Position pos;

  Movement movement;

  Unit(this.id, this.stat, {this.clan, this.pos, this.movement});
}

class UnitStat implements ActorStat {
  final int id;

  final Point<int> size;

  final FormationRole formationRole;

  int speed;

  UnitStat(this.id,
      {@required this.size,
      @required this.formationRole,
      @required this.speed});
}
