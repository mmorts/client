import 'dart:math';
import 'package:meta/meta.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'ser_helpers.dart';

part 'building_graphics.jser.dart';

@GenSerializer(fields: {
  "offset": Field(processor: const PointProcessor()),
  "loop": Field(isNullable: false)
})
class SpriteRefSpecSerializer extends Serializer<SpriteRefSpec>
    with _$SpriteRefSpecSerializer {
  @override
  T getJserDefault<T>(String field) {
    if (field == "loop") return true as T;
  }
}

class SpriteRefSpec {
  final String sprite;

  final Point<double> offset;

  final bool loop;

  final double rate;

  SpriteRefSpec(
      {@required this.sprite,
      @required this.offset,
      @required this.loop,
      @required this.rate});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => "SpriteRefSpec(${toJson().toString()})";

  static final serializer = SpriteRefSpecSerializer();
}

@GenSerializer(fields: {"offset": Field(processor: const PointProcessor())})
class BuildingLayerSpecSerializer extends Serializer<BuildingLayerSpec>
    with _$BuildingLayerSpecSerializer {}

class BuildingLayerSpec {
  final List<SpriteRefSpec> sprites;
  final int depth;
  final Point<double> offset;
  final String include;
  String name;
  BuildingLayerSpec(
      {@required this.sprites,
      this.depth: 0,
      this.offset: const Point<double>(0, 0),
      this.include});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => "BuildingLayerSpec(${toJson().toString()})";

  static final serializer = BuildingLayerSpecSerializer();
}

class BuildingGraphicsStateSpecSerializer
    extends Serializer<BuildingGraphicsStateSpec> {
  @override
  Map<String, dynamic> toMap(BuildingGraphicsStateSpec model) {
    if (model == null) return null;
    final ret = <String, dynamic>{};
    for (BuildingLayerSpec layer in model.layers) {
      ret[layer.name] = BuildingLayerSpec.serializer.toMap(layer);
    }
    return ret;
  }

  @override
  BuildingGraphicsStateSpec fromMap(Map map) {
    if (map == null) return null;
    final layers = <BuildingLayerSpec>[];
    for (String key in map.keys) {
      if (key == "") {
        // Dummy
      } else {
        layers.add(BuildingLayerSpec.serializer.fromMap(map[key])..name = key);
      }
    }
    return BuildingGraphicsStateSpec(layers: layers);
  }
}

class BuildingGraphicsStateSpec {
  List<BuildingLayerSpec> layers;

  BuildingGraphicsStateSpec({this.layers});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => "BuildingGraphicsStateSpec(${toJson().toString()})";

  static final serializer = BuildingGraphicsStateSpecSerializer();
}

@GenSerializer()
class BuildingGraphicsSpecSerializer extends Serializer<BuildingGraphicsSpec>
    with _$BuildingGraphicsSpecSerializer {}

class BuildingGraphicsSpec {
  // The graphics shown during construction.
  BuildingGraphicsStateSpec constructing;
  // The graphics shown normally
  BuildingGraphicsStateSpec standing;
  // The overlay graphics displayed when garrisoned.
  BuildingGraphicsStateSpec garrison;
  // The graphics shown when dying.
  BuildingGraphicsStateSpec dying;
  BuildingGraphicsStateSpec damage25;
  BuildingGraphicsStateSpec damage50;
  BuildingGraphicsStateSpec damage75;

  BuildingGraphicsSpec(
      {@required this.constructing,
      @required this.standing,
      @required this.garrison,
      @required this.dying,
      @required this.damage25,
      @required this.damage50,
      @required this.damage75});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  String toString() => "BuildingGraphicsSpec(${toJson().toString()})";

  static final serializer = BuildingGraphicsSpecSerializer();

  static BuildingGraphicsSpec decode(Map map) => serializer.fromMap(map);
}
