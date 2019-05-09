part of 'civilization.dart';

enum BuildingType {
  resource,
  military,
  gates,
}

// TODO garrison type

class Range {
  final int min;
  final int max;
  const Range({this.min, this.max});
}

class Building {
  final int id;
  final BuildingType type;
  final String name;
  final Shape shape;
  final Resource cost;
  final int buildTime;
  final double los;
  final int hp;
  final int armor;
  final int pierceArmor;
  final int faith;
  final Range range;
  final int blastRadius;
  final int attack;
  final int attackRate;
  final int selfHealRate;

  /// Number of projectiles fired when nobody is garrisoned in the building.
  final int baseProjectiles;

  /// Maximum number of projectiles that can be fired from the building.
  final int maxProjectiles;

  /// Accuracy of projectiles.
  final int accuracy;

  /// Maximum garrison capacity
  final int garrisonCapacity;

  /// Heal rate of garrisoned troops
  final int garrisonHealRate;

  /// Pop space provided by the building.
  final int popSpace;

  /// Units that can be recruited at the building.
  final Map<int, Locked<Unit>> units;

  /// Researches that can be researched at the building.
  final List<Locked<Research>> researches;

  const Building(
    this.id, {
    this.type,
    @required this.name,
    @required this.shape,
    @required this.cost,
    @required this.buildTime,
    @required this.hp,
    @required this.los,
    this.armor: 0,
    this.pierceArmor: 0,
    this.faith: 0,
    this.range,
    this.blastRadius,
    this.attack,
    this.attackRate,
    this.selfHealRate,
    this.baseProjectiles,
    this.maxProjectiles,
    this.accuracy,
    this.garrisonCapacity: 0,
    this.garrisonHealRate: 0,
    this.popSpace: 0,
    @required this.units,
    @required this.researches,
  });
}
