part of 'object.dart';

class BuildingStatInfo {
  final Player player;
  final Building template;
  Resource cost;
  int buildTime;
  double los;
  int hp;
  int armor;
  int pierceArmor;
  int faith;
  double minRange;
  double maxRange;
  int blastRadius;
  int attack;
  int attackRate;
  int selfHealRate;

  /// Attack bonus against unit classes
  final attackBonus = <DamageClass, int>{};

  int baseProjectiles;

  int maxProjectiles;

  int accuracy;
  int garrisonCapacity;
  int garrisonHealRate;
  int popSpace;

  BuildingStatInfo(
    this.player,
    this.template, {
    @required this.cost,
    @required this.buildTime,
    @required this.hp,
    @required this.los,
    @required this.armor,
    @required this.pierceArmor,
    @required this.faith,
    @required this.minRange,
    @required this.maxRange,
    @required this.blastRadius,
    @required this.attack,
    @required this.attackRate,
    @required this.selfHealRate,
    @required this.baseProjectiles,
    @required this.maxProjectiles,
    @required this.accuracy,
    @required this.garrisonCapacity,
    @required this.garrisonHealRate,
    @required this.popSpace,
  });

  factory BuildingStatInfo.fromTemplate(Player player, Building template) {
    final ret = BuildingStatInfo(player, template,
        cost: template.cost,
        buildTime: template.buildTime,
        hp: template.hp,
        los: template.los,
        armor: template.armor,
        pierceArmor: template.pierceArmor,
        faith: template.faith,
        minRange: template.minRange,
        maxRange: template.maxRange,
        blastRadius: template.blastRadius,
        attack: template.attack,
        attackRate: template.attackRate,
        selfHealRate: template.selfHealRate,
        baseProjectiles: template.baseProjectiles,
        maxProjectiles: template.maxProjectiles,
        accuracy: template.accuracy,
        garrisonCapacity: template.garrisonCapacity,
        garrisonHealRate: template.garrisonHealRate,
        popSpace: template.popSpace);
    ret.attackBonus.addAll(template.attackBonus);
    return ret;
  }

  void applyResearch(BuildingParameterChange change) {
    switch (change.parameter) {
      case BuildingParameter.cost1:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.wood += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.wood += (change.change * template.cost.wood) ~/ 100;
        }
        if (cost.wood < 0) cost.wood = 0;
        break;
      case BuildingParameter.cost2:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.food += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.food += (change.change * template.cost.food) ~/ 100;
        }
        if (cost.food < 0) cost.food = 0;
        break;
      case BuildingParameter.cost3:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.stone += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.stone += (change.change * template.cost.stone) ~/ 100;
        }
        if (cost.stone < 0) cost.stone = 0;
        break;
      case BuildingParameter.cost4:
        if (change.multiplier == ChangeMultiplier.absolute) {
          cost.gold += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          cost.gold += (change.change * template.cost.gold) ~/ 100;
        }
        if (cost.gold < 0) cost.gold = 0;
        break;
      case BuildingParameter.buildTime:
        // TODO
        break;
      case BuildingParameter.los:
        // TODO
        break;
      case BuildingParameter.hp:
        if (change.multiplier == ChangeMultiplier.absolute) {
          hp += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          hp += (change.change * template.hp) ~/ 100;
        }
        if (hp < 0) hp = 0;
        break;
      case BuildingParameter.armor:
        if (change.multiplier == ChangeMultiplier.absolute) {
          armor += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          armor += (change.change * template.armor) ~/ 100;
        }
        if (armor < 0) armor = 0;
        break;
      case BuildingParameter.pierceArmor:
        if (change.multiplier == ChangeMultiplier.absolute) {
          pierceArmor += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          pierceArmor += (change.change * template.pierceArmor) ~/ 100;
        }
        if (pierceArmor < 0) pierceArmor = 0;
        break;
      case BuildingParameter.faith:
        if (change.multiplier == ChangeMultiplier.absolute) {
          faith += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          faith += (change.change * template.faith) ~/ 100;
        }
        if (faith < 0) faith = 0;
        break;
      case BuildingParameter.minRange:
        // TODO
        break;
      case BuildingParameter.maxRange:
        // TODO
        break;
      case BuildingParameter.blastRadius:
        // TODO
        break;
      case BuildingParameter.attack:
        if (change.multiplier == ChangeMultiplier.absolute) {
          attack += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          attack += (change.change * template.attack) ~/ 100;
        }
        if (attack < 0) attack = 0;
        break;
      case BuildingParameter.attackRate:
        if (change.multiplier == ChangeMultiplier.absolute) {
          attackRate += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          attackRate += (change.change * template.attackRate) ~/ 100;
        }
        if (attackRate < 0) attackRate = 0;
        break;
      case BuildingParameter.accuracy:
        // TODO
        break;
      case BuildingParameter.selfHealRate:
        // TODO
        break;
      case BuildingParameter.baseProjectiles:
        // TODO
        break;
      case BuildingParameter.maxProjectiles:
        // TODO
        break;
      case BuildingParameter.accuracy:
        // TODO
        break;
      case BuildingParameter.garrisonCapacity:
        if (change.multiplier == ChangeMultiplier.absolute) {
          garrisonCapacity += change.change;
        } else if (change.multiplier == ChangeMultiplier.percent) {
          garrisonCapacity +=
              (change.change * template.garrisonCapacity) ~/ 100;
        }
        if (garrisonCapacity < 0) garrisonCapacity = 0;
        break;
      case BuildingParameter.garrisonHealRate:
        // TODO
        break;
      case BuildingParameter.popSpace:
        // TODO
        break;
    }
  }
}

class Building {
  final int id;

  final Building template;

  Player player;

  BuildingStatInfo statInfo;

  int hp;

  // TODO set garrison point

  final queue = <Activity>[];

  final recruitable = <int, UnitStatInfo>{};

  Building(this.id, this.template, this.player) {
    statInfo = player.statInfo.buildings[template.id];
    hp = statInfo.hp;
  }

  void convert(Player toPlayer) {
    // TODO
    // TODO cancel on-going events
    player.units.remove(id);
    player.firePopSpaceEvent();

    player = toPlayer;
    player.buildings[id] = this;
    statInfo = player.statInfo.buildings[template.id];
  }

  void enqueue(Activity activity) {
    queue.add(activity);
    if (queue.length == 1) {
      activity.start();
    }
  }

  void updateQueue() {
    if (queue.isEmpty) return;
    if (queue.first.hasFinished) {
      queue.removeAt(0);
    }
    if (queue.isEmpty) return;
    queue.first.start();
  }
}
