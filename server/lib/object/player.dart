part of 'object.dart';

class Player {
  final int id;

  final units = <int, Unit>{};

  final buildings = <int, Building>{};

  final CivilizationStat civilization;

  final researched = <int, bool>{};

  int age;

  Resource resources;

  // TODO player stats

  // TODO diplomacy

  Player(this.id, this.civilization);

  bool isResearchUnlocked(Locked<Research> research) {
    if(age < research.age) return false;
    // TODO check if [hasBuilding] is met
    if(!researched.containsKey(research.research.id)) return false;
    return true;
  }
}
