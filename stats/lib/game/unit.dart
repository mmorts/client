part of 'civilization.dart';

// TODO implement monk healing

// TODO garrison type

class UnitAbility {
  final int mask;

  final String name;

  const UnitAbility({this.mask, this.name});

  bool hasAbility(int abilities) => (abilities & mask) != 0;

  static const attack = UnitAbility(mask: 0x1, name: "Attack");
  static const lumber = UnitAbility(mask: 0x2, name: "Lumber");
  static const food = UnitAbility(mask: 0x4, name: "Food");
  static const mine = UnitAbility(mask: 0x8, name: "Mine");
}

class UnitStat {
  final int id;

  final String name;

  final Shape shape;

  final AttackType attackType;

  final List<DamageClass> damageClass;

  final int abilities;

  final Resource cost;

  final int trainTime;

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

  final Resource workRate;

  final Resource resCarry;

  UnitStat(this.id,
      {@required this.name,
      @required this.shape,
      @required this.attackType,
      @required this.damageClass,
      @required this.abilities,
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
      @required this.workRate,
      @required this.resCarry});
}

class UnitLine {
  final UnitStat unit;

  final Locked<UnitLine> upgrade;

  UnitLine({this.unit, this.upgrade});
}
