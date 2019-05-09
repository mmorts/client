part of 'civilization.dart';

/// Defines criteria when the [entity] becomes available.
class Locked<E> {
  /// The entity that is being locked
  final E entity;

  /// Should have this building for [entity] to be available
  final Building hasBuilding;

  /// Age after which unit is available for recruitment
  final int age;

  /// Research after which unit is available for recruitment
  final Research research;

  Locked(this.entity, {this.hasBuilding, this.age, this.research});
}

class Research {
  final int id;

  final String name;

  final Resource cost;

  final List<Upgrade> effects;

  // Number of seconds to research
  final int time;

  Research(this.id, {this.name, this.time, this.cost, this.effects});
}

enum ChangeMultiplier {
  absolute,
  percent,
}

abstract class Upgrade {}

class AgeUpgrade implements Upgrade {}

class CartographyUpgrade implements Upgrade {}

class UnitParamChange implements Upgrade {
  /// THe parameter that would be changed
  final UnitParameter parameter;

  final Unit byUnit;
  final UnitLine byUnitLine;
  final List<AttackType> byAttackType;
  final List<DamageClass> byDamageClass;

  final int change;
  final ChangeMultiplier multiplier;

  UnitParamChange(
      {@required this.parameter,
      @required this.byUnit,
      @required this.byUnitLine,
      @required this.byAttackType,
      @required this.byDamageClass,
      @required this.change,
      @required this.multiplier});
}

class BuildingParamUpgrade implements Upgrade {
  final BuildingParameter parameter;

  final List<Building> buildings;
  final BuildingType byType;

  final int change;
  final ChangeMultiplier multiplier;

  BuildingParamUpgrade(
      {this.buildings,
      this.byType,
      this.parameter,
      this.change,
      this.multiplier});
}

class MarketChange implements Upgrade {
  final MarketParameter parameter;
  final double change;
  final ChangeMultiplier multiplier;
  MarketChange({this.parameter, this.change, this.multiplier});
}

enum UnitParameter {
  cost1,
  cost2,
  cost3,
  cost4,
  trainTime,
  speed,
  los,
  hp,
  armor,
  pierceArmor,
  faith,
  minRange,
  maxRange,
  blastRadius,
  attack,
  attackRate,
  accuracy,
  selfHealRate,
  garrisonCapacity,
  garrisonHealRate,
  workRate1,
  workRate2,
  workRate3,
  workRate4,
  resCarry1,
  resCarry2,
  resCarry3,
  resCarry4,
}

enum BuildingParameter {
  cost1,
  cost2,
  cost3,
  cost4,
  buildTime,
  los,
  hp,
  armor,
  pierceArmor,
  faith,
  minRange,
  maxRange,
  blastRadius,
  attack,
  attackRate,
  selfHealRate,
  baseProjectiles,
  maxProjectiles,
  accuracy,
  garrisonCapacity,
  garrisonHealRate,
  popSpace,
}

enum MarketParameter {
  cartSpeed,
  tradeFee,
  tributeFee,
}
