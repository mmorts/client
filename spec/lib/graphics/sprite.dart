import 'dart:math';
import 'package:meta/meta.dart';

import '../serializer/serializer.dart';

/// Represents a frame in [Sprite]
class Frame {
  /// The number of pixels the image should be shifted
  /// to the left and up to place the frame at a specific
  /// position.
  final Point<int> hotspot;

  Frame({this.hotspot});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => toJson().toString();

  static final serializer = FrameSerializer();

  static Frame decode(Map data) => serializer.fromMap(data);
}

/// A sprite is a collection of one or many [Frame]s
class Sprite {
  final List<Frame> frames;

  Sprite({this.frames});

  int get numFrames => frames.length;

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => toJson().toString();

  static final serializer = SpriteSerializer();

  static Sprite decode(Map data) => serializer.fromMap(data);
}

/// Use [Compose] to compose a sprite [Layer].
///
/// Places [sprite] at [offset].
/// Set [loop] to true to loop the sprite.
/// [rate] specifies the rate at which the sprite is animated.
class Compose {
  final Sprite sprite;

  final Point<int> offset;

  final bool loop;

  final double rate;

  Compose(
      {@required this.sprite,
      this.offset: const Point(0, 0),
      this.loop: true,
      this.rate: 1.0});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => "SpriteRefSpec(${toJson().toString()})";

  static final serializer = ComposeSerializer();

  static Compose decode(Map data) => serializer.fromMap(data);
}

/// Use [Layer] to compose game graphics like [Building], etc.
class Layer {
  /// Name for the sprite layer
  String name;

  /// List of sprites composing the sprite layer
  final List<Compose> sprites;

  // final int depth;

  /// Offset
  final Point<int> offset;

  final String include;
  Layer(
      {this.name,
      @required this.sprites,
      // this.depth: 0,
      this.offset: const Point<int>(0, 0),
      this.include});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => "BuildingLayerSpec(${toJson().toString()})";

  static final serializer = LayerSerializer();

  static Layer decode(Map data) => serializer.fromMap(data);
}
