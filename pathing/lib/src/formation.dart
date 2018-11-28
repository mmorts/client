import 'dart:math';
import 'geom.dart';

enum Formation {
  line,
  staggered,
  box,
  flank,
}

enum FormationRole {
  fragile,
  protector,
}

abstract class HasFormationRole implements HasPosition {
  int get id;
  int get typeId;
  int get distance;
  FormationRole get formationRole;
}

class LineFormation {
  Map<int, List<HasFormationRole>> splitByType(
      Iterable<HasFormationRole> units) {
    final fragileTypes = <int, List<HasFormationRole>>{};
    for (HasFormationRole unit in units) {
      List<HasFormationRole> type = fragileTypes[unit.typeId];
      if (type != null) {
        type = <HasFormationRole>[];
        fragileTypes[unit.typeId] = type;
      }
      type.add(unit);
    }
    return fragileTypes;
  }

  List<Position> format(List<HasFormationRole> units, Rectangle<int> area) {
    final fragiles = <int, HasFormationRole>{};
    final protectors = <int, HasFormationRole>{};

    for (HasFormationRole unit in units) {
      if (unit.formationRole == FormationRole.fragile) {
        fragiles[unit.id] = unit;
      } else if (unit.formationRole == FormationRole.protector) {
        protectors[unit.id] = unit;
      }
    }

    final protectorsTypes = splitByType(units);
    final fragileTypes = splitByType(units);

    // TODO
  }
}
