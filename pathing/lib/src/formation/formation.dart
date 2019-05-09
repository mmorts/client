import 'dart:math';
import '../geom.dart';
import '../pathing.dart';
import '../game.dart';

export 'line.dart';

/// Enumerates formation type
enum FormationType {
  /// Line formation
  line,
  /// Staggered formation
  staggered,
  /// Box formation
  box,
  /// Flank formation
  flank,
}

/// A spot in formation
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

  void transform(Position to, Direction dir) {
    final rotator = _transformByDir[dir];
    spots.forEach((s) => s.transformedSpot = rotator(s.spot) + to);
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
  FormationResult format(Map<int, Map<int, Unit>> units, Point<int> area);
}

/// Find transformer to transform a formation into a required direction.
final _transformByDir = {
  Direction.n: (Position pos) => Position(x: pos.x, y: pos.y),
  Direction.ne: (Position pos) => Position(x: pos.x, y: pos.x + pos.y),
  Direction.e: (Position pos) => Position(x: -pos.y, y: pos.x),
  Direction.se: (Position pos) => Position(x: -pos.x, y: pos.x - pos.y),
  Direction.s: (Position pos) => Position(x: -pos.x, y: -pos.y),
  Direction.sw: (Position pos) => Position(x: -pos.x, y: -(pos.x + pos.y)),
  Direction.w: (Position pos) => Position(x: pos.y, y: -pos.x),
  Direction.nw: (Position pos) => Position(x: pos.x, y: -pos.x + pos.y),
};