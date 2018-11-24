part of 'object.dart';

class VillagerStatInfo {
  final Player player;

  final VillagerStat template;

  Resource cost;

  int trainTime;

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

  void applyResearch(VillagerParameterChange change) {
    switch (change.parameter) {
      case VillagerParameter.cost1:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.wood += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.wood += (change.change * template.cost.wood) ~/ 100;
        }
        if (cost.wood < 0) cost.wood = 0;
        break;
      case VillagerParameter.cost2:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.food += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.food += (change.change * template.cost.food) ~/ 100;
        }
        if (cost.food < 0) cost.food = 0;
        break;
      case VillagerParameter.cost3:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.stone += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.stone += (change.change * template.cost.stone) ~/ 100;
        }
        if (cost.stone < 0) cost.stone = 0;
        break;
      case VillagerParameter.cost4:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.gold += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.gold += (change.change * template.cost.gold) ~/ 100;
        }
        if (cost.gold < 0) cost.gold = 0;
        break;
      case VillagerParameter.trainTime:
        if (change.multiplier == ChangeMultiplier.absolute) {
          trainTime += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          trainTime += (change.change * template.trainTime) ~/ 100;
        }
        if (trainTime < 0) trainTime = 0;
        break;
      case VillagerParameter.speed:
      // TODO
        break;
      case VillagerParameter.los:
      // TODO
        break;
      case VillagerParameter.hp:
        if (change.multiplier == ChangeMultiplier.absolute) {
          hp += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          hp += (change.change * template.hp) ~/ 100;
        }
        if (hp < 0) hp = 0;
        break;
      case VillagerParameter.armor:
        if (change.multiplier == ChangeMultiplier.absolute) {
          armor += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          armor += (change.change * template.armor) ~/ 100;
        }
        if (armor < 0) armor = 0;
        break;
      case VillagerParameter.pierceArmor:
        if (change.multiplier == ChangeMultiplier.absolute) {
          pierceArmor += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          pierceArmor += (change.change * template.pierceArmor) ~/ 100;
        }
        if (pierceArmor < 0) pierceArmor = 0;
        break;
      case VillagerParameter.faith:
        if (change.multiplier == ChangeMultiplier.absolute) {
          faith += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          faith += (change.change * template.faith) ~/ 100;
        }
        if (faith < 0) faith = 0;
        break;
      case VillagerParameter.minRange:
      // TODO
        break;
      case VillagerParameter.maxRange:
      // TODO
        break;
      case VillagerParameter.blastRadius:
      // TODO
        break;
      case VillagerParameter.attack:
        if (change.multiplier == ChangeMultiplier.absolute) {
          attack += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          attack += (change.change * template.attack) ~/ 100;
        }
        if (attack < 0) attack = 0;
        break;
      case VillagerParameter.attackRate:
        if (change.multiplier == ChangeMultiplier.absolute) {
          attackRate += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          attackRate += (change.change * template.attackRate) ~/ 100;
        }
        if (attackRate < 0) attackRate = 0;
        break;
      case VillagerParameter.buildingAttackBonus:
        // TODO
        break;
      case VillagerParameter.workRate1:
        if (change.multiplier == ChangeMultiplier.absolute) {
          workRate.wood += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          workRate.wood += (change.change * template.workRate.wood) ~/ 100;
        }
        if (workRate.wood < 0) workRate.wood = 0;
        break;
      case VillagerParameter.workRate2:
        if (change.multiplier == ChangeMultiplier.absolute) {
          workRate.food += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          workRate.food += (change.change * template.workRate.food) ~/ 100;
        }
        if (workRate.food < 0) workRate.food = 0;
        break;
      case VillagerParameter.workRate3:
        if (change.multiplier == ChangeMultiplier.absolute) {
          workRate.stone += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          workRate.stone += (change.change * template.workRate.stone) ~/ 100;
        }
        if (workRate.stone < 0) workRate.stone = 0;
        break;
      case VillagerParameter.workRate4:
        if (change.multiplier == ChangeMultiplier.absolute) {
          workRate.gold += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          workRate.gold += (change.change * template.workRate.gold) ~/ 100;
        }
        if (workRate.gold < 0) workRate.gold = 0;
        break;
      case VillagerParameter.resCarry1:
        if (change.multiplier == ChangeMultiplier.absolute) {
          resCarry.wood += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          resCarry.wood += (change.change * template.resCarry.wood) ~/ 100;
        }
        if (resCarry.wood < 0) resCarry.wood = 0;
        break;
      case VillagerParameter.resCarry2:
        if (change.multiplier == ChangeMultiplier.absolute) {
          resCarry.food += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          resCarry.food += (change.change * template.resCarry.food) ~/ 100;
        }
        if (resCarry.food < 0) resCarry.food = 0;
        break;
      case VillagerParameter.resCarry3:
        if (change.multiplier == ChangeMultiplier.absolute) {
          resCarry.stone += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          resCarry.stone += (change.change * template.resCarry.stone) ~/ 100;
        }
        if (resCarry.stone < 0) resCarry.stone = 0;
        break;
      case VillagerParameter.resCarry4:
        if (change.multiplier == ChangeMultiplier.absolute) {
          resCarry.gold += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          resCarry.gold += (change.change * template.resCarry.gold) ~/ 100;
        }
        if (resCarry.gold < 0) resCarry.gold = 0;
        break;
    }
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
