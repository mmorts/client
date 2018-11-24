part of 'civilization.dart';

// TODO garrison type

class BuildingStat {
  final String name;
  final Shape shape;
  final List<DamageClass> damageClass;
  final Resource cost;
  final int buildTime;
  final double los;
  final int hp;
  final int armor;
  final int pierceArmor;
  final int faith;
  final double minRange;
  final double maxRange;
  final int blastRadius;
  final int attack;
  final int attackRate;
  final int selfHealRate;

  /// Attack bonus against unit classes
  final Map<DamageClass, int> attackBonus;

  final int baseProjectiles;

  final int maxProjectiles;

  final int accuracy;
  final int garrisonCapacity;
  final int garrisonHealRate;
  final int popSpace;
  final bool canRecruitVillager;
  final Map<int, Locked<UnitStat>> units;
  final Map<int, Locked<Research>> researches;

  BuildingStat({
    @required this.name,
    @required this.shape,
    @required this.damageClass,
    @required this.cost,
    @required this.buildTime,
    @required this.hp,
    @required this.los,
    @required this.armor,
    @required this.pierceArmor,
    @required this.faith,
    @required this.minRange,
    @required this.maxRange,
    @required this.blastRadius,
    @required this.attack,
    @required this.attackRate,
    @required this.selfHealRate,
    @required this.attackBonus,
    @required this.baseProjectiles,
    @required this.maxProjectiles,
    @required this.accuracy,
    @required this.garrisonCapacity,
    @required this.garrisonHealRate,
    @required this.popSpace,
    @required this.canRecruitVillager,
    @required this.units,
    @required this.researches,
  });
}
