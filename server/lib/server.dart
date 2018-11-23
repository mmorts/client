import 'dart:async';
import 'ability.dart';
import 'package:meta/meta.dart';
import 'object/object.dart';
import 'spatial/tile.dart';
import 'commands/commands.dart';

import 'package:stats/stats.dart';

typedef VoidFunc = void Function();

/// Currently ongoing activity
abstract class Activity {}

class ResearchActivity {
  final Player player;

  /// Building at which this activity occurs
  final Building building;

  final Research research;

  final Resource cost;

  /// Tick at which this activity completes
  final int seconds;

  Timer _timer;

  ResearchActivity(
      {@required this.player,
      @required this.building,
      @required this.research,
      @required this.seconds,
      @required this.cost,
      VoidFunc onComplete}) {
    _timer = Timer(Duration(seconds: seconds), onComplete);
  }

  void pause() {
    throw Exception("Pause not implemented!");
  }
}

class Activities {
  final research = <ResearchActivity>[];

  Activities();
}

class Game {
  DateTime _startTime;
  int _curTick = 0;

  final List<Tile> tiles;

  final Map<int, dynamic> objects;

  final List<Player> players;

  final List<Team> teams;

  final activities = Activities();

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
    Locked<Research> research = building.stat.researches[cmd.researchId];
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

    // Calculate seconds
    int seconds = research.research.time;

    // TODO send research added notification
    // TODO link to building, so that this is cancelled when the building is lost
    activities.research.add(ResearchActivity(
        player: player,
        building: building,
        research: research.research,
        seconds: seconds,
        cost: cost,
        onComplete: () {
          player.applyResearch(research.research);
          // TODO send research completed notification
        }));
    return null;
  }
}

class Team {
  final int id;

  final List<Player> players;

  Team({@required this.id, @required this.players});
}
