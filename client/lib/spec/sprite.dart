import 'dart:math';

class SpriteSpec {
  final List<Point<double>> hotspot;

  SpriteSpec({this.hotspot});

  int get numFrames => hotspot.length;

  static SpriteSpec decode(Map data) {
    final List<Point<double>> hotspots =
        (data["frames"] as List).cast<Map>().map((Map p) {
      List<num> offset = p["offset"]?.cast<num>();
      return Point<double>(offset[0].toDouble(), offset[1].toDouble());
    }).toList();

    return SpriteSpec(hotspot: hotspots);
  }
}
