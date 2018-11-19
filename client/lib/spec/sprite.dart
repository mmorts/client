import 'dart:math';

class SpriteSpec {
  /// Rate at which the sprite shall be animated
  final double rate;

  final List<Point<double>> hotspot;

  SpriteSpec({this.rate, this.hotspot});

  int get numFrames => hotspot.length;

  static SpriteSpec decode(Map data) {
    final double rate = data["rate"] ?? 0.0;
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

    return SpriteSpec(rate: rate, hotspot: hotspots);
  }
}
