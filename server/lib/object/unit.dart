part of 'object.dart';

class UnitStatInfo {
  final Player player;
  final UnitStat template;
  Resource cost;
  double trainTime;
  double speed;
  double los;
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
  final attackBonus = <DamageClass, int>{};
  int accuracy;
  int garrisonCapacity;
  int garrisonHealRate;

  UnitStatInfo(
    this.player,
    this.template, {
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
    @required this.blastRadius,
    @required this.attack,
    @required this.attackRate,
    @required this.accuracy,
    @required this.selfHealRate,
    @required this.garrisonCapacity,
    @required this.garrisonHealRate,
  });

  factory UnitStatInfo.fromStat(Player player, UnitStat stat) {
    final ret = UnitStatInfo(player, stat,
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
        blastRadius: stat.blastRadius,
        attack: stat.attack,
        attackRate: stat.attackRate,
        accuracy: stat.accuracy,
        selfHealRate: stat.selfHealRate,
        garrisonCapacity: stat.garrisonCapacity,
        garrisonHealRate: stat.garrisonHealRate);
    ret.attackBonus.addAll(stat.attackBonus);
    return ret;
  }

  void applyResearch(UnitParameterChange change) {
    switch (change.parameter) {
      case UnitParameter.cost1:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.wood += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.wood += (change.change * template.cost.wood) ~/ 100;
        }
        if (cost.wood < 0) cost.wood = 0;
        break;
      case UnitParameter.cost2:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.food += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.food += (change.change * template.cost.food) ~/ 100;
        }
        if (cost.food < 0) cost.food = 0;
        break;
      case UnitParameter.cost3:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.stone += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.stone += (change.change * template.cost.stone) ~/ 100;
        }
        if (cost.stone < 0) cost.stone = 0;
        break;
      case UnitParameter.cost4:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.gold += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.gold += (change.change * template.cost.gold) ~/ 100;
        }
        if (cost.gold < 0) cost.gold = 0;
        break;
      case UnitParameter.trainTime:
        if (change.multiplier == ChangeMultiplier.absolute) {
          trainTime += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          trainTime += (change.change * template.trainTime) ~/ 100;
        }
        if (trainTime < 0) trainTime = 0;
        break;
      case UnitParameter.speed:
        // TODO
        break;
      case UnitParameter.los:
        // TODO
        break;
      case UnitParameter.hp:
        if (change.multiplier == ChangeMultiplier.absolute) {
          hp += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          hp += (change.change * template.hp) ~/ 100;
        }
        if (hp < 0) hp = 0;
        break;
      case UnitParameter.armor:
        if (change.multiplier == ChangeMultiplier.absolute) {
          armor += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          armor += (change.change * template.armor) ~/ 100;
        }
        if (armor < 0) armor = 0;
        break;
      case UnitParameter.pierceArmor:
        if (change.multiplier == ChangeMultiplier.absolute) {
          pierceArmor += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          pierceArmor += (change.change * template.pierceArmor) ~/ 100;
        }
        if (pierceArmor < 0) pierceArmor = 0;
        break;
      case UnitParameter.faith:
        if (change.multiplier == ChangeMultiplier.absolute) {
          faith += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          faith += (change.change * template.faith) ~/ 100;
        }
        if (faith < 0) faith = 0;
        break;
      case UnitParameter.minRange:
        // TODO
        break;
      case UnitParameter.maxRange:
        // TODO
        break;
      case UnitParameter.blastRadius:
        // TODO
        break;
      case UnitParameter.attack:
        if (change.multiplier == ChangeMultiplier.absolute) {
          attack += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          attack += (change.change * template.attack) ~/ 100;
        }
        if (attack < 0) attack = 0;
        break;
      case UnitParameter.attackRate:
        if (change.multiplier == ChangeMultiplier.absolute) {
          attackRate += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          attackRate += (change.change * template.attackRate) ~/ 100;
        }
        if (attackRate < 0) attackRate = 0;
        break;
      case UnitParameter.accuracy:
        // TODO
        break;
      case UnitParameter.selfHealRate:
        // TODO
        break;
      case UnitParameter.garrisonCapacity:
        if (change.multiplier == ChangeMultiplier.absolute) {
          garrisonCapacity += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          garrisonCapacity +=
              (change.change * template.garrisonCapacity) ~/ 100;
        }
        if (garrisonCapacity < 0) garrisonCapacity = 0;
        break;
      case UnitParameter.garrisonHealRate:
        // TODO
        break;
    }
  }
}

class Unit {
  final int id;

  final UnitStat template;

  UnitStatInfo statInfo;

  Player player;

  int hp;

  Unit(this.id, this.template, this.player) {
    statInfo = player.statInfo.units[template.id];
    hp = statInfo.hp;
  }

  void convert(Player toPlayer) {
    // TODO cancel on-going events
    player.units.remove(id);
    player.firePopSpaceEvent();

    player = toPlayer;
    player.units[id] = this;
    statInfo = player.statInfo.units[template.id];
  }
}
