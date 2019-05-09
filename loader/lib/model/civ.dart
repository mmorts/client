import 'package:meta/meta.dart';

import 'building.dart';
import 'unit.dart';

class Civ {
  final Map<int, Building> buildings;

  final Map<int, Unit> units;

  Civ({@required this.buildings, @required this.units});
}

class Graphics {
  final List<Civ> civs;

  Graphics(this.civs);
}
