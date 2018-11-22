part of 'civilization.dart';

class BuildingStat {
  final String name;
  final Shape shape;
  final Resource cost;
  final int hp;
  final double los;
  final int garrisonCapacity;
  final int garrisonHealRate;
  final int popSpace;
  final int popFill;
  final List<Availability<UnitStat>> units;
  final List<Availability<Research>> researches;

  BuildingStat({
    @required this.name,
    @required this.shape,
    @required this.cost,
    @required this.hp,
    @required this.los,
    @required this.garrisonCapacity,
    @required this.garrisonHealRate,
    @required this.popSpace,
    @required this.popFill,
    @required this.units,
    @required this.researches,
  });
}
