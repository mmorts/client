import 'dart:math';
import 'package:slp_reader/slp_reader.dart';
import 'package:yamlicious/yamlicious.dart';

Map<String, dynamic> convert(List<Frame> frames) {
  if (frames.isEmpty) throw Exception("Frames cannot be empty!");

  Point hotspot = frames.first.info.hotspot;

  final ret = <String, dynamic>{};

  if (frames.every((f) => f.info.hotspot == hotspot)) {
    ret["hx"] = hotspot.x;
    ret["hy"] = hotspot.y;
    if (frames.length != 1) {
      ret["numFrames"] = frames.length;
    }
  } else {
    ret["frames"] = frames
        .map((f) => {"hx": f.info.hotspotX, "hy": f.info.hotspotY})
        .toList();
  }

  return ret;
}

String convertToYaml(List<Frame> frames) => toYamlString(convert(frames));
