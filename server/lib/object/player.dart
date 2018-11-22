part of 'object.dart';

class Player {
  final int id;

  final units = <int, Unit>{};

  final buildings = <int, Building>{};

  final CivilizationStat civilization;

  final research = <int, bool>{};

  int age;

  // TODO player stats

  // TODO diplomacy

  Player(this.id, this.civilization);
}
