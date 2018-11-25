import 'package:meta/meta.dart';

part 'unit.dart';
part 'building.dart';
part 'common.dart';
part 'research.dart';

/// Defines criteria when the [entity] becomes available.
class Locked<E> {
  final E entity;

  /// Should have this building for [entity] to be available
  final BuildingStat hasBuilding;

  /// Age after which unit is available for recruitment
  final int age;

  /// Research after which unit is available for recruitment
  final Research research;

  Locked({this.entity, this.hasBuilding, this.age, this.research});
}

class CivAgeStat {
  final List<ParameterChanges> bonus;

  CivAgeStat({this.bonus});
}

class StartingStat {
  final int villagers;
  final Map<UnitStat, int> units;
  // TODO final Map<Building, int> buildings;
  StartingStat({
    @required this.villagers,
    @required this.units,
    // TODO @required this.buildings,
  });
}

class CivilizationStat {
  final String name;
  final List<CivAgeStat> ages;
  final Map<int, Locked<BuildingStat>> buildings;
  final List<Locked<ParameterChanges>> civBonus;
  final List<Locked<ParameterChanges>> teamBonus;
  final StartingStat startWith;

  CivilizationStat(
      {@required this.name,
      @required this.ages,
      @required this.buildings,
      @required this.civBonus,
      @required this.teamBonus,
      @required this.startWith});
}

class GameStat {
  final List<String> ages;
  final List<CivilizationStat> civs;

  GameStat({@required this.civs, @required this.ages});
}
