part of 'object.dart';

class VillagerStatInfo {
  final Player player;

  final VillagerStat template;

  Resource cost;

  double trainTime;

  double speed;

  double los;

  int hp;

  int armor;

  int pierceArmor;

  int faith;

  double minRange;

  double maxRange;

  int attack;

  int attackRate;

  Resource workRate;

  Resource resCarry;

  VillagerStatInfo(this.player, this.template,
      {@required this.cost,
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

  factory VillagerStatInfo.fromStat(Player player, VillagerStat stat) {
    final ret = VillagerStatInfo(
      player,
      stat,
      cost: stat.cost.clone(),
      trainTime: stat.trainTime,
      speed: stat.speed,
      los: stat.los,
      hp: stat.hp,
      armor: stat.armor,
      pierceArmor: stat.pierceArmor,
      faith: stat.faith,
      minRange: stat.minRange,
      maxRange: stat.maxRange,
      attack: stat.attack,
      attackRate: stat.attackRate,
      workRate: stat.workRate.clone(),
      resCarry: stat.resCarry.clone(),
    );
    return ret;
  }
}

class Villager {
  final int id;

  final VillagerStat template;

  VillagerStatInfo statInfo;

  Player player;

  int hp;

  Villager(this.id, this.template, this.player) {
    statInfo = player.statInfo.villager;
    hp = statInfo.hp;
  }

  void convert(Player toPlayer) {
    // TODO cancel on-going events
    player.villagers.remove(id);
    player.firePopSpaceEvent();

    player = toPlayer;
    player.villagers[id] = this;
    statInfo = player.statInfo.villager;
  }
}
