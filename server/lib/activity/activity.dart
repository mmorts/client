import 'dart:async';
import 'package:meta/meta.dart';
import 'package:server/object/object.dart';
import 'package:spec/stats.dart' as stats;

typedef VoidFunc = void Function();

/// Currently ongoing activity
abstract class Activity {
  void start();

  void pause();

  bool get hasStarted;

  bool get hasFinished;
}

class ResearchActivity implements Activity {
  final int id;

  final Player player;

  /// Building at which this activity occurs
  final Building building;

  final stats.Research research;

  final stats.Resource cost;

  Timer _timer;

  bool _finished = false;

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
    _finished = true;
    if (player != building.player) return;

    player.applyResearch(research);
    // TODO send research completed notification
    building.updateQueue();
  }

  bool get hasStarted => _timer != null;

  bool get hasFinished => _finished;
}

class UnitRecruitmentActivity implements Activity {
  final int id;

  final Player player;

  final Building building;

  final stats.Resource cost;

  final UnitStatInfo statInfo;

  Timer _timer;

  bool _finished = false;

  UnitRecruitmentActivity(this.id,
      {@required this.player,
      @required this.building,
      @required this.cost,
      @required this.statInfo});

  void start() {
    _timer =
        Timer(Duration(seconds:statInfo.trainTime), _onFinish);
  }

  void pause() {
    throw Exception("Pause not implemented!");
  }

  void _onFinish() {
    _finished = true;
    if (player != building.player) return;

    // TODO
    player.addUnit(building, statInfo);
    building.updateQueue();
    // TODO
  }

  bool get hasStarted => _timer != null;

  bool get hasFinished => _finished;
}

class Activities {
  final unitCreation = <int, UnitRecruitmentActivity>{};

  final research = <int, ResearchActivity>{};

  int _idCounter = 0;

  Activities();

  int get newId => _idCounter++;
}
