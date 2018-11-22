part of 'civilization.dart';

// TODO cartography
// TODO research/bonus to reduce research cost

class ParameterChanges {
  final List<UnitParameterChange> unit;
  final List<BuildingParameterChange> building;
  final List<VillageParameterChange> villager;
  final List<MarketParameterChange> market;
  final int age;

  ParameterChanges(
      {this.unit, this.building, this.villager, this.market, this.age});
}

class Research {
  final String name;

  final Resource cost;

  final ParameterChanges effect;

  // Number of seconds to research
  final int time;

  Research({this.name, this.time, this.cost, this.effect});
}

enum UnitParameter {
  cost1,
  cost2,
  cost3,
  cost4,
  creationSpeed,
  speed,
  los,
  hp,
  armor,
  pierceArmor,
  terrainDefenseBonus,
  faith,
  minRange,
  maxRange,
  blastRadius,
  attack,
  attackRate,
  buildingAttackBonus,
  accuracy,
  selfHealRate,
  garrisonCapacity,
  garrisonHealRate,
}

class UnitParameterChange {
  final UnitStat byUnit;
  final UnitLine byUnitLine;
  final List<AttackType> byAttackType;
  final List<AttackClass> byAttackClass;
  final UnitParameter parameter;
  final double change;
  UnitParameterChange(
      {@required this.byUnit,
      @required this.byUnitLine,
      @required this.byAttackType,
      @required this.byAttackClass,
      @required this.parameter,
      @required this.change});
}

enum BuildingParameter {
  cost1,
  cost2,
  cost3,
  cost4,
  hp,
  los,
  garrisonCapacity,
  garrisonHealRate,
}

class BuildingParameterChange {
  final UnitParameter parameter;
  final double change;
  BuildingParameterChange({this.parameter, this.change});
}

enum VillagerParameter {
  cost1,
  cost2,
  cost3,
  cost4,
  creationSpeed,
  speed,
  los,
  hp,
  armor,
  pierceArmor,
  minRange,
  range,
  blastRadius,
  attack,
  buildingAttackBonus,
  workRate1,
  workRate2,
  workRate3,
  workRate4,
  resCarry1,
  resCarry2,
  resCarry3,
  resCarry4,
}

class VillageParameterChange {
  final UnitParameter parameter;
  final double change;
  VillageParameterChange({this.parameter, this.change});
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
