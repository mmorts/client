part of 'civilization.dart';

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