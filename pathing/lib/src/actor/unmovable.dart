import 'dart:math';
import 'package:meta/meta.dart';

import 'package:pathing/src/geom.dart';

import 'actor.dart';

abstract class Unmovable implements Actor {
  int get id;

  UnmovableStat get stat;

  Position get pos;
}

class UnmovableStat implements ActorStat {
  final int id;

  final Point<int> size;

  UnmovableStat(
    this.id, {
    @required this.size,
  });
}
