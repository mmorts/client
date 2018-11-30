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

  final int unitType;

  Unit unit;

  Position transformedSpot;

  FormationSpot(this.spot, this.unitType);
}

class FormationResult {
  final Map<int, List<FormationSpot>> spotsMap;

  final List<FormationSpot> spots;

  final FormationSpot reference;

  FormationResult(this.spotsMap, this.spots, this.reference);

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

abstract class FormationMaker {
  FormationResult format(Map<int, Map<int, Unit>> units, Point<int> area,
      Map<int, UnitStat> stats);
}

class LineFormation implements FormationMaker {
  FormationResult format(Map<int, Map<int, Unit>> units, Point<int> area,
      Map<int, UnitStat> stats) {
    final fragiles = <int, Map<int, Unit>>{};
    final protectors = <int, Map<int, Unit>>{};

    for (int unitTypeId in units.keys) {
      final stat = stats[unitTypeId];
      if (stat.formationRole == FormationRole.fragile) {
        fragiles[unitTypeId] = units[unitTypeId];
      } else if (stat.formationRole == FormationRole.protector) {
        protectors[unitTypeId] = units[unitTypeId];
      }
    }

    final spotsMap = <int, List<FormationSpot>>{};
    final spots = <FormationSpot>[];

    int vSpaceTaken = 0;

    Function allocator = (Map<int, Map<int, Unit>> unitMapping) {
      for (int unitTypeId in unitMapping.keys) {
        final Map<int, Unit> units = unitMapping[unitTypeId];
        final int numUnits = units.length;
        final int unitWidth = 1; // TODO units.first.stat.distance.x * 2;
        final int unitHeight = 1; // TODO units.first.stat.distance.y * 2;
        int maxInRow = area.x ~/ unitWidth;
        if (maxInRow > 10) maxInRow = 10;
        int numRows = (numUnits / maxInRow).ceil();

        final currentSpots = <FormationSpot>[];
        for (int i = 0; i < numRows; i++) {
          int maxInThisRow = maxInRow;
          if(i == numRows - 1) {
            maxInThisRow = numUnits % maxInRow;
            if(maxInThisRow == 0) maxInThisRow = maxInRow;
          }
          for (int j = 0; j < maxInThisRow; j++) {
            final spot = FormationSpot(
                Position(
                    x: ((j - maxInThisRow ~/ 2) * unitWidth).toInt(),
                    y: vSpaceTaken),
                unitTypeId);
            currentSpots.add(spot);
            spots.add(spot);
          }
          vSpaceTaken += unitHeight;
        }
        spotsMap[unitTypeId] = currentSpots;
      }
    };

    allocator(protectors);
    allocator(fragiles);

    FormationSpot reference =
        spots.firstWhere((s) => s.spot.x == 0 && s.spot.y == 0);

    return FormationResult(spotsMap, spots, reference);
  }
}
