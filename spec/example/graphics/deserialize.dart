import 'dart:io';
import 'dart:math';
import 'package:spec/graphics.dart';
import 'package:yaml/yaml.dart';

final data = """
constructing:
  - sprite: building/cnst3
standing:
  - sprite: building/barrack/dark
garrison:
  - sprite: building/flag1
    offset: [0, 0]
  - sprite: building/flag1
    offset: [0, 0]
dying:
  - sprite: TODO
hp25:
  - sprite: TODO
hp50:
  - sprite: TODO
hp75:
  - sprite: TODO
""";

main() async {
  final map = loadYaml(data);
  print(map);

  final building = Building.decode(map);
  print(building);
}
