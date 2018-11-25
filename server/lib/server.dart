import 'package:meta/meta.dart';
import 'object/object.dart';
import 'spatial/tile.dart';
import 'commands/commands.dart';

import 'package:stats/stats.dart';

import 'activity/activity.dart';

class Game {
  DateTime _startTime;
  int _curTick = 0;

  final List<Tile> tiles;

  final Map<int, dynamic> objects;

  final List<Player> players;

  final List<Team> teams;

  Game(
      {@required this.tiles,
      @required this.objects,
      @required this.players,
      @required this.teams});

  int get curTick => _curTick;

  DateTime get startTime => _startTime;

  void start() {
    _startTime = DateTime.now();
    // TODO set things in motion
  }

  void processTick() {
    for (;;) {
      // TODO implement pausing the game
      _curTick = DateTime.now().difference(_startTime).inMilliseconds;

      // TODO
    }
  }

  final _wrongCommands = <int, int>{};

  /// Queues "research" commands
  String addResearchCommand(Player player, ResearchCommand cmd) {
    // Check if building exists
    Building building = player.buildings[cmd.buildingId];
    if (building == null) {
      _wrongCommands[player.id] = (_wrongCommands[player.id] ?? 0) + 1;
      return "Building does not exist!";
    }

    // Check if research is already performed
    if (player.researched.containsKey(cmd.researchId)) {
      _wrongCommands[player.id] = (_wrongCommands[player.id] ?? 0) + 1;
      return "Research already performed!";
    }

    // Check if research exists
    Locked<Research> research = building.template.researches[cmd.researchId];
    if (research == null) {
      _wrongCommands[player.id] = (_wrongCommands[player.id] ?? 0) + 1;
      return "Research does not exist!";
    }

    // Check if research is unlocked
    if (!player.isResearchUnlocked(research)) {
      _wrongCommands[player.id] = (_wrongCommands[player.id] ?? 0) + 1;
      return "Research is not unlocked!";
    }

    // Calculate cost
    Resource cost = research.research.cost;

    // Check if resources exist
    if (player.resources < cost) {
      _wrongCommands[player.id] = (_wrongCommands[player.id] ?? 0) + 1;
      return "Not enough resources!";
    }

    // TODO send research added notification
    // TODO link to building, so that this is cancelled when the building is lost
    final int id = player.activities.newId;
    final activity = ResearchActivity(
      id,
      player: player,
      building: building,
      research: research.research,
      cost: cost,
    );
    player.activities.research[id] = activity;
    building.enqueue(activity);
    return null;
  }

  String addRecruitArmyCommand(Player player, RecruitArmy cmd) {
    // Check if building exists
    Building building = player.buildings[cmd.buildingId];
    if (building == null) {
      _wrongCommands[player.id] = (_wrongCommands[player.id] ?? 0) + 1;
      return "Building does not exist!";
    }

    final statInfo = building.recruitable[cmd.unitId];
    if (statInfo == null) {
      _wrongCommands[player.id] = (_wrongCommands[player.id] ?? 0) + 1;
      return "Unit not recruitable!";
    }

    // TODO take amount into consideration

    Resource cost = statInfo.cost;

    // Check if resources exist
    if (player.resources < cost) {
      _wrongCommands[player.id] = (_wrongCommands[player.id] ?? 0) + 1;
      return "Not enough resources!";
    }

    int id = player.activities.newId;
    final activity = UnitRecruitmentActivity(id,
        player: player, building: building, cost: cost, statInfo: statInfo);
    player.activities.unitCreation[id] = activity;
    building.enqueue(activity);
    return null;
  }

  String addMoveUnit(Player player, MoveUnits cmd) {

    // Collect all units
    final units = <int, Unit>{};
    for(final id in cmd.unitId) {
      units[id] = player.units[id];
    }

    // TODO remove from other formation

    // TODO put into formation

    // TODO Compute pathing

    // TODO set the move task

    // TODO
  }
}

class Team {
  final int id;

  final List<Player> players;

  Team({@required this.id, @required this.players});
}
