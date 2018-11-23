part of 'civilization.dart';

// TODO implement monk healing

// TODO garrison type

class UnitStat {
  final String name;

  final Shape shape;

  final AttackType attackType;

  final List<DamageClass> damageClass;

  final Resource cost;

  final double trainTime;

  final double speed;

  final double los;

  final int hp;

  final int armor;

  final int pierceArmor;

  final int faith;

  final double minRange;

  final double maxRange;

  final double blastRadius;

  final int attack;

  final int attackRate;

  final int selfHealRate;

  /// Attack bonus against unit classes
  final Map<DamageClass, int> attackBonus;

  final int accuracy;

  final int garrisonCapacity;

  final int garrisonHealRate;

  UnitStat({
    @required this.name,
    @required this.shape,
    @required this.attackType,
    @required this.damageClass,
    @required this.cost,
    @required this.trainTime,
    @required this.speed,
    @required this.los,
    @required this.hp,
    @required this.armor,
    @required this.pierceArmor,
    @required this.faith,
    @required this.minRange,
    @required this.maxRange,
    @required this.blastRadius,
    @required this.attack,
    @required this.attackRate,
    @required this.attackBonus,
    @required this.accuracy,
    @required this.selfHealRate,
    @required this.garrisonCapacity,
    @required this.garrisonHealRate,
  });
}

class Upgrade<T> {
  final T unit;

  final Resource cost;

  Upgrade({this.unit, this.cost});
}

class UnitLine {
  final UnitStat unit;

  final Locked<Upgrade<UnitLine>> upgrade;

  UnitLine({this.unit, this.upgrade});
}
