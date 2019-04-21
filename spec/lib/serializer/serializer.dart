import 'dart:math';
import 'package:jaguar_serializer/jaguar_serializer.dart';

import '../spec/building.dart';

/*
part 'serializer.jser.dart';

class PointProcessor implements FieldProcessor<Point<double>, List> {
  const PointProcessor();

  @override
  Point<double> deserialize(List value) {
    if (value == null) return null;
    return Point<double>(value[0].toDouble(), value[1].toDouble());
  }

  @override
  List<double> serialize(Point<double> value) {
    if (value == null) return null;
    return [value.x, value.y];
  }
}

@GenSerializer(fields: {
  "offset": Field(processor: const PointProcessor()),
  "loop": Field(isNullable: false)
})
class SpriteRefSpecSerializer extends Serializer<SpriteRef>
    with _$SpriteRefSpecSerializer {
  @override
  T getJserDefault<T>(String field) {
    if (field == "loop") return true as T;
    return null;
  }
}

@GenSerializer(fields: {"offset": Field(processor: const PointProcessor())})
class BuildingLayerSpecSerializer extends Serializer<Layer>
    with _$BuildingLayerSpecSerializer {}

@GenSerializer()
class BuildingGraphicsSerializer extends Serializer<Building>
    with _$BuildingGraphicsSerializer {}

class BuildingGraphicsStateSpecSerializer
    extends Serializer<BuildingState> {
  @override
  Map<String, dynamic> toMap(BuildingState model) {
    if (model == null) return null;
    final ret = <String, dynamic>{};
    for (Layer layer in model.layers) {
      ret[layer.name] = Layer.serializer.toMap(layer);
    }
    return ret;
  }

  @override
  BuildingState fromMap(Map map) {
    if (map == null) return null;
    final layers = <Layer>[];
    for (String key in map.keys) {
      if (key == "") {
        // Dummy
      } else {
        layers.add(Layer.serializer.fromMap(map[key])..name = key);
      }
    }
    return BuildingState(layers: layers);
  }
}

@GenSerializer()
class SpriteSpecSerializer extends Serializer<SpriteSpec>
    with _$SpriteSpecSerializer {}

@GenSerializer(fields: {"hotspot": Field(processor: const PointProcessor())})
class FrameSpecSerializer extends Serializer<FrameSpec>
    with _$FrameSpecSerializer {}
 */
