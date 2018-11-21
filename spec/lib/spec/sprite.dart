import 'dart:math';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'ser_helpers.dart';

part 'sprite.jser.dart';

class FrameSpec {
  final Point<double> hotspot;

  FrameSpec({this.hotspot});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => toJson().toString();

  static final serializer = FrameSpecSerializer();

  static FrameSpec decode(Map data) => serializer.fromMap(data);
}

@GenSerializer(fields: {"hotspot": Field(processor: const PointProcessor())})
class FrameSpecSerializer extends Serializer<FrameSpec>
    with _$FrameSpecSerializer {}

class SpriteSpec {
  final List<FrameSpec> frames;

  SpriteSpec({this.frames});

  int numFrames() => frames.length;

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => toJson().toString();

  static final serializer = SpriteSpecSerializer();

  static SpriteSpec decode(Map data) => serializer.fromMap(data);
}

@GenSerializer()
class SpriteSpecSerializer extends Serializer<SpriteSpec>
    with _$SpriteSpecSerializer {}
