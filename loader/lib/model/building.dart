import 'package:meta/meta.dart';

import 'sprite.dart';

class BuildingAge {
  final List<Graphic> constructing;
  final List<Graphic> standing;
  final List<Graphic> garrison;
  final List<Graphic> dying;
  final List<Graphic> hp25;
  final List<Graphic> hp50;
  final List<Graphic> hp75;

  BuildingAge(
      {@required this.constructing,
      @required this.standing,
      @required this.garrison,
      @required this.dying,
      @required this.hp25,
      @required this.hp50,
      @required this.hp75});
}

class Building {
  final BuildingAge age0;
  final BuildingAge age1;
  final BuildingAge age2;
  final BuildingAge age3;

  List<BuildingAge> get ages => [age0, age1, age2, age3];

  Building({this.age0, this.age1, this.age2, this.age3});
}
