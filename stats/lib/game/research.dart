part of 'civilization.dart';

// TODO cartography

enum ChangeMultiplier {
  absolute,
  percent,
}

class ParameterChanges {
  final List<UnitParameterChange> unit;
  final List<BuildingParameterChange> building;
  final List<MarketParameterChange> market;
  final int age;

  ParameterChanges(
      {this.unit, this.building, this.market, this.age});
}

class Research {
  final int id;

  final String name;

  final Resource cost;

  final ParameterChanges effect;

  // Number of seconds to research
  final int time;

  Research({this.id, this.name, this.time, this.cost, this.effect});
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

class UnitParameterChange {
  final UnitStat byUnit;
  final UnitLine byUnitLine;
  final List<AttackType> byAttackType;
  final List<DamageClass> byDamageClass;

  final UnitParameter parameter;

  final int change;

  final ChangeMultiplier multiplier;

  UnitParameterChange(
      {@required this.byUnit,
      @required this.byUnitLine,
      @required this.byAttackType,
      @required this.byDamageClass,
      @required this.parameter,
      @required this.change,
      @required this.multiplier});
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

class BuildingParameterChange {
  final List<BuildingStat> buildings;
  final BuildingType byType;
  final BuildingParameter parameter;
  final int change;
  final ChangeMultiplier multiplier;
  BuildingParameterChange(
      {this.buildings,
      this.byType,
      this.parameter,
      this.change,
      this.multiplier});
}

enum MarketParameter {
  cartSpeed,
  tradeFee,
  tributeFee,
}

class MarketParameterChange {
  final MarketParameter parameter;
  final double change;
  MarketParameterChange({this.parameter, this.change});
}
