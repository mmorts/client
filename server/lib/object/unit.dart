part of 'object.dart';

class Unit {
  final int id;
  final UnitStat stat;

  Player player;

  double speed;
  double los;
  int maxHp;
  int hp;
  int armor;
  int pierceArmor;

  int terrainDefenseBonus;
  int faith;
  double minRange;
  double maxRange;
  double blastRadius;
  int attack;
  int attackRate;
  int buildingAttackBonus;
  int selfHealRate;

  // TODO attackBonus;

  int accuracy;

  int garrisonCapacity;

  int garrisonHealRate;

  Unit(this.id, this.stat);
}