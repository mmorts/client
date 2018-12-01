import 'dart:math';
import 'package:pathing/src/geom.dart';
import 'package:pathing/src/pathing.dart';
import 'package:pathing/src/unit.dart';
import 'package:pathing/src/formation.dart';

part 'no_formation.dart';
part 'with_formation.dart';

class UnitInMovement {
  final int id;

  final Unit unit;

  Path path;

  FormationSpot spot;

  int acceleration = 0;

  int needsUpdate = 0;

  UnitInMovement(Unit unit)
      : id = unit.id,
        unit = unit;
}

abstract class Movement {
  int get id;

  bool get finished;

  void removeUnit(Unit t);

  void tick();

  void dispose();
}
