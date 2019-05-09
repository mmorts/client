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

class Unit {
  final int id;

  final String name;

  final Shape shape;

  final AttackType attackType;

  final List<DamageClass> damageClass;

  // final int abilities;

  final Resource cost;

  final int trainTime;

  final double speed;

  final double los;

  final int hp;

  final int armor;

  final int pierceArmor;

  final int faith;

  final Range range;

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

  Unit(this.id,
      {@required this.name,
      @required this.shape,
      @required this.attackType,
      @required this.damageClass,
      // @required this.abilities,
      @required this.cost,
      @required this.trainTime,
      @required this.speed,
      @required this.los,
      @required this.hp,
      this.armor: 0,
      this.pierceArmor: 0,
      this.faith: 0,
      this.range: const Range(min: 0, max: 0),
      this.blastRadius: 0,
      @required this.attack,
      @required this.attackRate,
      @required this.attackBonus,
      this.accuracy: 0,
      this.selfHealRate: 0,
      this.garrisonCapacity: 0,
      this.garrisonHealRate: 0,
      this.workRate,
      this.resCarry});
}

/// A line of units that can be enabled sequentially
class UnitLine {
  /// Current unit in the line
  final Unit unit;

  /// Next upgrade
  final Locked<UnitLine> upgrade;

  UnitLine({this.unit, this.upgrade});
}
