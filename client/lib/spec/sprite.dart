import 'dart:math';

class SpriteSpec {
  final List<Point<double>> hotspot;

  SpriteSpec({this.hotspot});

  int get numFrames => hotspot.length;

  static SpriteSpec decode(Map data) {
    List<Point<double>> hotspots;
    if (data.containsKey("frames")) {
      hotspots = (data["frames"] as List)
          .cast<Map>()
          .map((Map p) => Point<double>(p["hx"].toDouble(), p["hy"].toDouble()))
          .toList();
    } else if (data["hx"] is! int && data["hy"] is! int) {
      final hotspot = Point<double>(data["x"].toDouble(), data["y"].toDouble());
      final int numFrames = data["numFrames"] ?? 1;
      hotspots = List<Point<double>>.filled(numFrames, hotspot);
    } else {
      throw Exception("Invalid sprite file format!");
    }

    return SpriteSpec(hotspot: hotspots);
  }
}
