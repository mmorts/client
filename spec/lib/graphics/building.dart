import 'package:meta/meta.dart';

import 'sprite.dart';

import 'serializer/serializer.dart';

/// Specifies building graphics
class Building {
  /// The graphics shown during construction.
  List<Compose> constructing;

  /// The graphics shown normally
  List<Compose> standing;

  /// The overlay graphics displayed when garrisoned.
  List<Compose> garrison;

  /// The graphics shown when dying.
  List<Compose> dying;

  /// The graphics shown when the building is at 25% hp
  List<Compose> hp25;

  /// The graphics shown when the building is at 50% hp
  List<Compose> hp50;

  /// The graphics shown when the building is at 75% hp
  List<Compose> hp75;

  Building(
      {@required this.constructing,
      @required this.standing,
      @required this.garrison,
      @required this.dying,
      @required this.hp25,
      @required this.hp50,
      @required this.hp75});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => "BuildingGraphicsSpec(${toJson().toString()})";

  static final serializer = BuildingSerializer();

  static Building decode(Map map) => serializer.fromMap(map);
}
