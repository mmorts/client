import 'dart:math';
import 'package:jaguar_serializer/jaguar_serializer.dart';

import '../spec/spec.dart';

part 'serializer.jser.dart';

/*

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
 */

class IntPointProcessor implements FieldProcessor<Point<int>, List> {
  const IntPointProcessor();

  @override
  Point<int> deserialize(List value) {
    if (value == null) return null;
    return Point<int>(value[0].toInt(), value[1].toInt());
  }

  @override
  List<int> serialize(Point<int> value) {
    if (value == null) return null;
    return [value.x, value.y];
  }
}

@GenSerializer()
class SpriteSerializer extends Serializer<Sprite> with _$SpriteSerializer {}

@GenSerializer(
    fields: {"hotspot": Field(processor: const IntPointProcessor())},
    ignore: ['numFrames'])
class FrameSerializer extends Serializer<Frame> with _$FrameSerializer {}

@GenSerializer(fields: {"offset": Field(processor: const IntPointProcessor())},)
class ComposeSerializer extends Serializer<Compose> with _$ComposeSerializer {}

@GenSerializer(fields: {"offset": Field(processor: const IntPointProcessor())},)
class LayerSerializer extends Serializer<Layer> with _$LayerSerializer {}
