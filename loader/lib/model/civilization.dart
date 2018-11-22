import 'package:meta/meta.dart';

enum AttackType {
  melee,
  projectile,
  bullet,
  siege,
}

class Resource {
  int wood;

  int food;

  int stone;

  int gold;

  Resource(
      {@required this.wood,
      @required this.food,
      @required this.gold,
      @required this.stone});
}

abstract class Shape {}

class CircleShape extends Shape {
  final double radius;

  CircleShape(this.radius);
}

class RectangleShape extends Shape {
  final double width;

  final double height;

  RectangleShape({this.width, this.height});
}

class AttackClass {
  final int id;

  final String name;

  AttackClass({this.id, this.name});
}

class Unit {
  final String name;

  final Shape shape;

  final List<AttackClass> attackClass;

  final Resource cost;

  final double creationSpeed;

  final double speed;

  final double los;

  final int hp;

  final int armor;

  final int pierceArmor;

  final double minRange;

  final double range;

  final int blastRadius;

  final int attack;

  final int buildingAttackBonus;

  /// Attack bonus against unit classes
  final Map<int, int> attackBonus;

  Unit(
      {@required this.name,
      @required this.shape,
      @required this.attackClass,
      @required this.cost,
      @required this.creationSpeed,
      @required this.speed,
      @required this.los,
      @required this.hp,
      @required this.armor,
      @required this.pierceArmor,
      @required this.minRange,
      @required this.range,
      @required this.blastRadius,
      @required this.attack,
      @required this.buildingAttackBonus,
      @required this.attackBonus});
}

class Villager {
  final Resource cost;

  final Shape shape;

  final double creationSpeed;

  final double speed;

  final double los;

  final int hp;

  final int armor;

  final int pierceArmor;

  final double minRange;

  final double range;

  final int blastRadius;

  final int attack;

  final int buildingAttackBonus;

  final Resource workRate;

  final Resource resCarry;

  Villager(
      {@required this.shape,
      @required this.cost,
      @required this.creationSpeed,
      @required this.speed,
      @required this.los,
      @required this.hp,
      @required this.armor,
      @required this.pierceArmor,
      @required this.minRange,
      @required this.range,
      @required this.blastRadius,
      @required this.attack,
      @required this.buildingAttackBonus,
      @required this.workRate,
      @required this.resCarry});
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

/// Defines criteria when the [entity] becomes available.
class Availability<E> {
  final E entity;

  /// Research after which unit is available for recruitment
  final Building hasBuilding;

  /// Age after which unit is available for recruitment
  final int age;

  /// Research after which unit is available for recruitment
  final Research research;

  Availability({this.entity, this.hasBuilding, this.age, this.research});
}

class Research {
  final String name;

  List<UnitParameterChange> unit;
  // TODO

  Research({this.name});
}

class Building {
  final String name;
  final Shape shape;
  final Resource cost;
  final int hp;
  final double los;
  final List<Availability<Unit>> units;
  final List<Availability<Research>> researches;

  Building(
      {@required this.name,
      @required this.shape,
      @required this.cost,
      this.hp,
      this.los,
      @required this.units,
      @required this.researches});
}

class CivAge {
  final List<UnitParameterChange> unitBoosts;
  final List<BuildingParameterChange> buildingBoosts;

  CivAge({this.unitBoosts, this.buildingBoosts});
}

class Civilization {
  final String name;
  final List<CivAge> ages;
  final Map<int, Availability<Building>> buildings;

  Civilization(
      {@required this.name, @required this.ages, @required this.buildings});
}

class Game {
  final List<String> ages;
  final List<Civilization> civs;

  Game({@required this.civs, @required this.ages});
}

enum UnitParameter {
  cost,
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
}

class UnitParameterChange {
  final List<AttackType> byAttackType;
  final List<AttackClass> byAttackClass;
  final UnitParameter parameter;
  final double change;
  UnitParameterChange({this.parameter, this.change, this.byAttackType});
}

enum BuildingParameter {
  cost,
  hp,
  los,
}

class BuildingParameterChange {
  // TODO select by unit class/type
  final UnitParameter parameter;
  final double change;
  BuildingParameterChange({this.parameter, this.change});
}

enum VillagerParameter {
  cost,
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
}
