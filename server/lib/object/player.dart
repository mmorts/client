part of 'object.dart';

class PlayerStatInfo {
  final units = <int, UnitStatInfo>{};

  final unitsByAttackType = <stats.AttackType, List<UnitStatInfo>>{};

  final unitsByDamageClass = <int, List<UnitStatInfo>>{};

  final buildings = <int, BuildingStatInfo>{};

  PlayerStatInfo();
}

class Player {
  final int id;

  final activities = Activities();

  final statInfo = PlayerStatInfo();

  final units = <int, Unit>{};

  final buildings = <int, Building>{};

  final stats.Civilization civilization;

  final researched = <int, bool>{};

  int age;

  Resource resources;

  // TODO player stats

  // TODO diplomacy

  Player(this.id, this.civilization);

  bool isResearchUnlocked(Locked<Research> research) {
    if (age < research.age) return false;
    // TODO check if [hasBuilding] is met
    if (!researched.containsKey(research.research.id)) return false;
    return true;
  }

  void applyUnitResearch(UnitParameterChange change) {
    final applied = HashSet<int>();

    final apply = (Unit unit) {
      if (applied.contains(unit.id)) return;
      applied.add(unit.id);

      final unitStatInfo = statInfo.units[unit.id];
      if (unitStatInfo == null) return;

      // TODO increase hp
      unitStatInfo.applyResearch(change);
    };

    // By Unit
    if (change.byUnit != null) {
      apply(change.byUnit);
    }

    // By Unit line
    if (change.byUnitLine != null) {
      UnitLine line = change.byUnitLine;
      do {
        apply(line.unit);
        line = line.upgrade?.entity;
      } while (line != null);
    }

    // By attack type
    for (AttackType type in change.byAttackType) {
      for (UnitStatInfo sinfo in statInfo.unitsByAttackType[type]) {
        apply(sinfo.template);
      }
    }

    // By damage class
    for (DamageClass type in change.byDamageClass) {
      for (UnitStatInfo sinfo in statInfo.unitsByDamageClass[type.id]) {
        apply(sinfo.template);
      }
    }
  }

  void applyBuildingResearch(BuildingParameterChange change) {
    final applied = HashSet<int>();

    final apply = (Building building) {
      if (applied.contains(building.id)) return;
      applied.add(building.id);

      final buildingStatInfo = statInfo.buildings[building.id];
      if (buildingStatInfo == null) return;

      // TODO increase hp
      buildingStatInfo.applyResearch(change);
    };

    if (change.buildings == null && change.byType != null) {
      for (final building in statInfo.buildings.values) {
        apply(building.template);
      }
    } else {
      if (change.buildings != null) {
        for (final building in change.buildings) {
          apply(building);
        }
      }

      if (change.byType != null) {
        for (final building in statInfo.buildings.values) {
          if (building.template.type == change.byType) {
            apply(building.template);
          }
        }
      }
    }
  }

  void applyResearch(Research research) {
    researched[research.id] = true;

    for (final change in research.effect.unit) {
      applyUnitResearch(change);
    }

    for (final change in research.effect.building) {
      applyBuildingResearch(change);
    }

    // TODO market

    // TODO monk
  }

  void addUnit(Building building, UnitStatInfo statInfo) {
    // TODO what if population is reached?
    // TODO
    int id;
    // TODO find a place to put the unit
    final unit = Unit(id, statInfo.template, this);
    units[id] = unit;
  }

  void firePopSpaceEvent() {
    // TODO
  }
}
