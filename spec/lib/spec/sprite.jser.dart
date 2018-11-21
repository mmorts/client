// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sprite.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$FrameSpecSerializer implements Serializer<FrameSpec> {
  final _pointProcessor = const PointProcessor();
  @override
  Map<String, dynamic> toMap(FrameSpec model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'hotspot', _pointProcessor.serialize(model.hotspot));
    return ret;
  }

  @override
  FrameSpec fromMap(Map map) {
    if (map == null) return null;
    final obj = new FrameSpec(
        hotspot: _pointProcessor.deserialize(map['hotspot'] as List) ??
            getJserDefault('hotspot'));
    return obj;
  }
}

abstract class _$SpriteSpecSerializer implements Serializer<SpriteSpec> {
  Serializer<FrameSpec> __frameSpecSerializer;
  Serializer<FrameSpec> get _frameSpecSerializer =>
      __frameSpecSerializer ??= new FrameSpecSerializer();
  @override
  Map<String, dynamic> toMap(SpriteSpec model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(
        ret,
        'frames',
        codeIterable(model.frames,
            (val) => _frameSpecSerializer.toMap(val as FrameSpec)));
    return ret;
  }

  @override
  SpriteSpec fromMap(Map map) {
    if (map == null) return null;
    final obj = new SpriteSpec(
        frames: codeIterable<FrameSpec>(map['frames'] as Iterable,
                (val) => _frameSpecSerializer.fromMap(val as Map)) ??
            getJserDefault('frames'));
    return obj;
  }
}
