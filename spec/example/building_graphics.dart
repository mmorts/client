import 'dart:io';
import 'package:spec/spec.dart';
import 'package:yaml/yaml.dart';

main() async {
  final file = loadYaml(await File('example/barrack.yaml').readAsString());
  final spec = BuildingGraphicsSpec.decode(file);
  print(spec);
}