import 'dart:async';
import 'package:meta/meta.dart';
import 'package:server/object/object.dart';
import 'package:stats/stats.dart';

typedef VoidFunc = void Function();

/// Currently ongoing activity
abstract class Activity {}

class ResearchActivity {
  /// Building at which this activity occurs
  final Building building;

  final Research research;

  final Resource cost;

  /// Tick at which this activity completes
  final int seconds;

  Timer _timer;

  ResearchActivity(
      {@required this.building,
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

class VillagerCreateActivity {
  final Building building;

  final Resource cost;

  /// Tick at which this activity completes
  final int seconds;

  Timer _timer;

  VillagerCreateActivity(
      {this.building, this.cost, this.seconds, VoidFunc onComplete}) {
    _timer = Timer(Duration(seconds: seconds), onComplete);
  }
}

class Activities {
  final villagerCreation = <VillagerCreateActivity>[];

  final research = <ResearchActivity>[];

  Activities();
}