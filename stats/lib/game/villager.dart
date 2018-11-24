part of 'civilization.dart';

class VillagerStat {
  final Shape shape;

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

  final int attack;

  final int attackRate;

  final Resource workRate;

  final Resource resCarry;

  VillagerStat(
      {@required this.shape,
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
        @required this.attack,
        @required this.attackRate,
        @required this.workRate,
        @required this.resCarry});
}