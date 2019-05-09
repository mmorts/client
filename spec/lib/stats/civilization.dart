import 'package:meta/meta.dart';

part 'unit.dart';
part 'building.dart';
part 'common.dart';
part 'research.dart';

class CivAge {
  final List<Upgrade> bonus;

  CivAge({this.bonus});
}

class StartWith {
  /// Number of villagers the civilization starts with
  final int villagers;

  StartWith({
    @required this.villagers,
  });
}

class Civilization {
  /// Name of the civilization
  final String name;

  /// Age stats
  final List<CivAge> ages;

  /// Building stats
  final Map<int, Locked<Building>> buildings;

  /// Civilization bonus stats
  final List<Locked<Upgrade>> civBonus;

  /// Team bonus stats
  final List<Locked<Upgrade>> teamBonus;

  final StartWith startWith;

  Civilization(
      {@required this.name,
      @required this.ages,
      @required this.buildings,
      @required this.civBonus,
      @required this.teamBonus,
      @required this.startWith});
}

class Game {
  final List<Civilization> civs;

  Game({@required this.civs});
}
