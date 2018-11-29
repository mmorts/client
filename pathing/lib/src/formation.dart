import 'dart:math';
import 'geom.dart';
import 'unit.dart';

enum Formation {
  line,
  staggered,
  box,
  flank,
}

class FormationSpot {
  final Position spot;

  Unit unit;

  Position transformedSpot;

  FormationSpot(this.spot);
}

class FormationResult {
  final Map<int, List<FormationSpot>> spotsMap;

  final List<FormationSpot> spots;

  FormationResult(this.spotsMap, this.spots);

  void transform(Position to) {
    spots.forEach((s) =>
        s.transformedSpot = Position(x: s.spot.x + to.x, y: s.spot.y + to.y));
  }

  FormationSpot getFreeSpotFor(int unitType) {
    List<FormationSpot> s = spotsMap[unitType];
    if (s == null) return null;

    // TODO optimize finding empty spot
    final free = s.firstWhere((fs) => fs.unit == null, orElse: () => null);
    if (free == null) return null;

    return free;
  }
}

class LineFormation {
  Map<int, List<Unit>> splitByType(Iterable<Unit> units) {
    final fragileTypes = <int, List<Unit>>{};
    for (Unit unit in units) {
      List<Unit> type = fragileTypes[unit.stat.id];
      if (type == null) {
        type = <Unit>[];
        fragileTypes[unit.stat.id] = type;
      }
      type.add(unit);
    }
    return fragileTypes;
  }

  FormationResult format(Iterable<Unit> units, Point<int> area) {
    final fragiles = <int, Unit>{};
    final protectors = <int, Unit>{};

    for (Unit unit in units) {
      if (unit.stat.formationRole == FormationRole.fragile) {
        fragiles[unit.id] = unit;
      } else if (unit.stat.formationRole == FormationRole.protector) {
        protectors[unit.id] = unit;
      }
    }

    final protectorsTypes = splitByType(protectors.values);
    final fragileTypes = splitByType(fragiles.values);

    final spotsMap = <int, List<FormationSpot>>{};
    final spots = <FormationSpot>[];

    int vSpaceTaken = 0;

    Function allocator = (Map<int, List<Unit>> unitMapping) {
      for (int unitTypeId in unitMapping.keys) {
        final List<Unit> units = unitMapping[unitTypeId];
        final int numUnits = units.length;
        final int unitWidth = 1; // TODO units.first.stat.distance.x * 2;
        final int unitHeight = 1; // TODO units.first.stat.distance.y * 2;
        int maxInRow = area.x ~/ unitWidth;
        if (maxInRow > 10) maxInRow = 10;
        int numRows = (numUnits / maxInRow).ceil();

        final currentSpots = <FormationSpot>[];
        for (int i = 0; i < numRows; i++) {
          for (int j = 0; j < maxInRow; j++) {
            final spot = FormationSpot(Position(
                x: ((j - maxInRow ~/ 2) * unitWidth).toInt(), y: vSpaceTaken));
            currentSpots.add(spot);
            spots.add(spot);
          }
          vSpaceTaken += unitHeight;
        }
        spotsMap[unitTypeId] = currentSpots;
      }
    };

    allocator(protectorsTypes);
    allocator(fragileTypes);

    return FormationResult(spotsMap, spots);
  }
}
