import 'dart:math';
import 'package:meta/meta.dart';

class Frame {
  final Point<double> hotspot;

  Frame({this.hotspot});

  /*
  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => toJson().toString();

  static final serializer = FrameSpecSerializer();

  static FrameSpec decode(Map data) => serializer.fromMap(data);
   */
}

class Sprite {
  final List<Frame> frames;

  Sprite({this.frames});

  int numFrames() => frames.length;

  /*
  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => toJson().toString();

  static final serializer = SpriteSpecSerializer();

  static SpriteSpec decode(Map data) => serializer.fromMap(data);
  */
}

/// Use [Layer] to compose game graphics like [Building], etc.
class Layer {
  /// Name for the sprite layer
  String name;

  /// List of sprites composing the sprite layer
  final List<Compose> sprites;

  // final int depth;

  /// Offset
  final Point<double> offset;

  final String include;
  Layer(
      {this.name,
        @required this.sprites,
        // this.depth: 0,
        this.offset: const Point<double>(0, 0),
        this.include});

/*
  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => "BuildingLayerSpec(${toJson().toString()})";

  static final serializer = BuildingLayerSerializer();
   */
}

/// Use [Compose] to compose a sprite [Layer].
///
/// Places [sprite] at [offset].
/// Set [loop] to true to loop the sprite.
/// [rate] specifies the rate at which the sprite is animated.
class Compose {
  final Sprite sprite;

  final Point<double> offset;

  final bool loop;

  final double rate;

  Compose(
      {@required this.sprite,
        this.offset: const Point(0, 0),
        this.loop: true,
        this.rate: 1.0});

/*
  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => "SpriteRefSpec(${toJson().toString()})";

  static final serializer = SpriteRefSerializer();
   */
}
