import 'dart:math';

class SpriteSpec {
  /// Rate at which the sprite shall be animated
  final double rate;

  final List<Point<int>> hotspot;

  SpriteSpec({this.rate, this.hotspot});

  static SpriteSpec decode(Map data) {
    final double rate = data["rate"] ?? 0.0;
    List<Point<int>> hotspots;
    if (data.containsKey("frames")) {
      hotspots = (data["frames"] as List)
          .cast<Map>()
          .map((Map p) => Point<int>(p["hx"], p["hy"]))
          .toList();
    } else if (data["hx"] is! int && data["hy"] is! int) {
      final hotspot = Point<int>(data["x"], data["y"]);
      final int numFrames = data["numFrames"] ?? 1;
      hotspots = List<Point<int>>.filled(numFrames, hotspot);
    } else {
      throw Exception("Invalid sprite file format!");
    }

    return SpriteSpec(rate: rate, hotspot: hotspots);
  }
}
