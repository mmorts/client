part of 'civilization.dart';

class Villager {
  final Shape shape;

  final Resource cost;

  final double creationTime;

  final double speed;

  final double los;

  final int hp;

  final int armor;

  final int pierceArmor;

  final int faith;

  final double minRange;

  final double maxRange;

  final int attack;

  final Resource workRate;

  final Resource resCarry;

  Villager(
      {@required this.shape,
        @required this.cost,
        @required this.creationTime,
        @required this.speed,
        @required this.los,
        @required this.hp,
        @required this.armor,
        @required this.pierceArmor,
        @required this.faith,
        @required this.minRange,
        @required this.maxRange,
        @required this.attack,
        @required this.workRate,
        @required this.resCarry});
}