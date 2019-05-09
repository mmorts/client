import 'dart:math';
import 'package:meta/meta.dart';

import 'package:pathing/src/geom.dart';

import 'actor.dart';

class Unmovable implements Actor {
  final int id;

  UnmovableStat stat;

  Position pos;

  Unmovable(this.id, this.stat, {this.pos});
}

class UnmovableStat implements ActorStat {
  final int id;

  final Point<int> size;

  UnmovableStat(
    this.id, {
    @required this.size,
  });
}
