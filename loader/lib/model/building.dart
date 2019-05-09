import 'package:meta/meta.dart';

import 'sprite_ref.dart';

class BuildingGraphic {
  final List<Graphic> constructing;
  final List<Graphic> standing;
  final List<Graphic> garrison;
  final List<Graphic> dying;
  final List<Graphic> hp25;
  final List<Graphic> hp50;
  final List<Graphic> hp75;

  BuildingGraphic(
      {@required this.constructing,
      @required this.standing,
      @required this.garrison,
      @required this.dying,
      @required this.hp25,
      @required this.hp50,
      @required this.hp75});
}

class BuildingAges {
  final List<BuildingGraphic> age0;
  final List<BuildingGraphic> age1;
  final List<BuildingGraphic> age2;
  final List<BuildingGraphic> age3;

  BuildingAges({this.age0, this.age1, this.age2, this.age3});
}
