part of 'civilization.dart';

// TODO implement monk healing

class Unit {
  final String name;

  final Shape shape;

  final AttackType attackType;

  final List<AttackClass> attackClass;

  final Resource cost;

  final double creationSpeed;

  final double speed;

  final double los;

  final int hp;

  final int armor;

  final int pierceArmor;

  final int terrainDefenseBonus;

  final int faith;

  final double minRange;

  final double maxRange;

  final int blastRadius;

  final int attack;

  final int attackRate;

  final int buildingAttackBonus;

  final int autoHealRate;

  /// Attack bonus against unit classes
  final Map<int, int> attackBonus;

  final int accuracy;

  final int garrisonCapacity;

  final int garrisonHealRate;

  Unit({
    @required this.name,
    @required this.shape,
    @required this.attackType,
    @required this.attackClass,
    @required this.cost,
    @required this.creationSpeed,
    @required this.speed,
    @required this.los,
    @required this.hp,
    @required this.armor,
    @required this.pierceArmor,
    @required this.terrainDefenseBonus,
    @required this.faith,
    @required this.minRange,
    @required this.maxRange,
    @required this.blastRadius,
    @required this.attack,
    @required this.attackRate,
    @required this.buildingAttackBonus,
    @required this.attackBonus,
    @required this.accuracy,
    @required this.autoHealRate,
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
  final Unit unit;

  final Availability<Upgrade<UnitLine>> upgrade;

  UnitLine({this.unit, this.upgrade});
}
