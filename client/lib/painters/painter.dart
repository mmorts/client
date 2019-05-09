import 'dart:web_gl';

import 'building/painter.dart';
import 'package:client/painters/military/military.dart';
import 'terrain.dart';
import 'resource.dart';

class Painter {
  final BuildingPainter building;

  final MilitaryPainter military;

  final TerrainPainter terrain;

  Painter._({this.building, this.military, this.terrain});

  static Future<Painter> make(RenderingContext2 gl) async {
    final building = await BuildingPainter.make(gl);
    final military = await MilitaryPainter.make(gl);
    final terrain = await TerrainPainter.make(gl);
    // TODO
    return Painter._(building: building, military: military, terrain: terrain);
  }
}
