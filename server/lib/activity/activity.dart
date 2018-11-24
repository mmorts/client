import 'dart:async';
import 'package:meta/meta.dart';
import 'package:server/object/object.dart';
import 'package:stats/stats.dart';

typedef VoidFunc = void Function();

/// Currently ongoing activity
abstract class Activity {
  void start();

  void pause();
}

class ResearchActivity implements Activity {
  final int id;

  final Player player;

  /// Building at which this activity occurs
  final Building building;

  final Research research;

  final Resource cost;

  Timer _timer;

  ResearchActivity(this.id,
      {@required this.player,
      @required this.building,
      @required this.research,
      @required this.cost});

  void start() {
    _timer = Timer(Duration(seconds: research.time), _onFinish);
  }

  void pause() {
    throw Exception("Pause not implemented!");
  }

  void _onFinish() {
    if (player != building.player) return;

    player.applyResearch(research);
    // TODO send research completed notification
  }
}

class VillagerCreateActivity implements Activity {
  final int id;

  final Player player;

  final Building building;

  final Resource cost;

  Timer _timer;

  VillagerCreateActivity(this.id, {this.player, this.building, this.cost});

  void start() {
    _timer =
        Timer(Duration(seconds: player.statInfo.villager.trainTime), _onFinish);
  }

  void pause() {
    throw Exception("Pause not implemented!");
  }

  void _onFinish() {
    if (player != building.player) return;

    // TODO
  }
}

class Activities {
  final villagerCreation = <int, VillagerCreateActivity>{};

  final research = <int, ResearchActivity>{};

  Activities();
}
