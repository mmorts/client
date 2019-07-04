import 'dart:math';
import 'package:pathing/src/geom.dart';
import 'package:pathing/src/pathing.dart';
import 'package:pathing/src/game.dart';
import 'package:pathing/src/formation/formation.dart';
import '../actor/internal.dart';

part 'no_formation.dart';
part 'with_formation.dart';

class UnitInMovement {
  final int id;

  final MovableWrap unit;

  Path path;

  FormationSpot spot;

  int acceleration = 0;

  int needsUpdate = 0;

  Position curDest;

  UnitInMovement(Movable unit)
      : id = unit.id,
        unit = unit;
}

abstract class Movement {
  int get id;

  bool get finished;

  void removeUnit(MovableWrap t);

  void tick();

  void dispose();
}
