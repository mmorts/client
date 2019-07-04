import 'dart:math';

export 'movable.dart';
export 'unmovable.dart';

abstract class Actor {
  int get id;
}

abstract class ActorStat {
  int get id;

  Point<int> get size;
}