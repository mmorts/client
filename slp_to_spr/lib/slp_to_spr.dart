import 'dart:math';
import 'package:slp_reader/slp_reader.dart';
import 'package:spec/spec.dart';
import 'package:yamlicious/yamlicious.dart';

Map<String, dynamic> convert(List<Frame> frames) {
  if (frames.isEmpty) throw Exception("Frames cannot be empty!");

  return SpriteSpec(
          frames: frames
              .map((f) => FrameSpec(
                  hotspot: Point<double>(
                      f.info.hotspotX.toDouble(), f.info.hotspotY.toDouble())))
              .toList())
      .toJson();
}

String convertToYaml(List<Frame> frames) => toYamlString(convert(frames));
