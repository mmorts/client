import 'package:meta/meta.dart';

part 'unit.dart';
part 'building.dart';
part 'common.dart';
part 'villager.dart';
part 'research.dart';

/// Defines criteria when the [entity] becomes available.
class Availability<E> {
  final E entity;

  /// Should have this building for [entity] to be available
  final Building hasBuilding;

  /// Age after which unit is available for recruitment
  final int age;

  /// Research after which unit is available for recruitment
  final Research research;

  Availability({this.entity, this.hasBuilding, this.age, this.research});
}

class CivAge {
  final List<ParameterChanges> bonus;

  CivAge({this.bonus});
}

class Starting {
  final int villagers;
  final Map<Unit, int> units;
  // TODO final Map<Building, int> buildings;
  Starting({
    @required this.villagers,
    @required this.units,
    // TODO @required this.buildings,
  });
}

class Civilization {
  final String name;
  final List<CivAge> ages;
  final Map<int, Availability<Building>> buildings;
  final List<Availability<ParameterChanges>> civBonus;
  final List<Availability<ParameterChanges>> teamBonus;
  final Starting startWith;

  Civilization(
      {@required this.name,
      @required this.ages,
      @required this.buildings,
      @required this.civBonus,
      @required this.teamBonus,
      @required this.startWith});
}

class Game {
  final List<String> ages;
  final List<Civilization> civs;

  Game({@required this.civs, @required this.ages});
}
