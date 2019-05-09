// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializer.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$SpriteSerializer implements Serializer<Sprite> {
  Serializer<Frame> __frameSerializer;
  Serializer<Frame> get _frameSerializer =>
      __frameSerializer ??= new FrameSerializer();
  @override
  Map<String, dynamic> toMap(Sprite model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(
        ret,
        'frames',
        codeIterable(
            model.frames, (val) => _frameSerializer.toMap(val as Frame)));
    return ret;
  }

  @override
  Sprite fromMap(Map map) {
    if (map == null) return null;
    final obj = new Sprite(
        frames: codeIterable<Frame>(map['frames'] as Iterable,
                (val) => _frameSerializer.fromMap(val as Map)) ??
            getJserDefault('frames'));
    return obj;
  }
}

abstract class _$FrameSerializer implements Serializer<Frame> {
  final _intPointProcessor = const IntPointProcessor();
  @override
  Map<String, dynamic> toMap(Frame model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'hotspot', _intPointProcessor.serialize(model.hotspot));
    return ret;
  }

  @override
  Frame fromMap(Map map) {
    if (map == null) return null;
    final obj = new Frame(
        hotspot: _intPointProcessor.deserialize(map['hotspot'] as List) ??
            getJserDefault('hotspot'));
    return obj;
  }
}

abstract class _$ComposeSerializer implements Serializer<Compose> {
  final _intPointProcessor = const IntPointProcessor();
  @override
  Map<String, dynamic> toMap(Compose model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'sprite', model.sprite);
    setMapValue(ret, 'offset', _intPointProcessor.serialize(model.offset));
    setMapValue(ret, 'loop', model.loop);
    setMapValue(ret, 'rate', model.rate);
    return ret;
  }

  @override
  Compose fromMap(Map map) {
    if (map == null) return null;
    final obj = new Compose(
        sprite: map['sprite'] as String ?? getJserDefault('sprite'),
        offset: _intPointProcessor.deserialize(map['offset'] as List) ??
            getJserDefault('offset'),
        loop: map['loop'] as bool ?? getJserDefault('loop'),
        rate: map['rate'] as double ?? getJserDefault('rate'));
    return obj;
  }
}

abstract class _$LayerSerializer implements Serializer<Layer> {
  final _intPointProcessor = const IntPointProcessor();
  Serializer<Compose> __composeSerializer;
  Serializer<Compose> get _composeSerializer =>
      __composeSerializer ??= new ComposeSerializer();
  @override
  Map<String, dynamic> toMap(Layer model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'name', model.name);
    setMapValue(
        ret,
        'compose',
        codeIterable(
            model.compose, (val) => _composeSerializer.toMap(val as Compose)));
    setMapValue(ret, 'offset', _intPointProcessor.serialize(model.offset));
    setMapValue(ret, 'include', model.include);
    return ret;
  }

  @override
  Layer fromMap(Map map) {
    if (map == null) return null;
    final obj = new Layer(
        compose: codeIterable<Compose>(map['compose'] as Iterable,
                (val) => _composeSerializer.fromMap(val as Map)) ??
            getJserDefault('compose'),
        offset: _intPointProcessor.deserialize(map['offset'] as List) ??
            getJserDefault('offset'),
        include: map['include'] as String ?? getJserDefault('include'));
    obj.name = map['name'] as String;
    return obj;
  }
}

abstract class _$BuildingSerializer implements Serializer<Building> {
  Serializer<Compose> __composeSerializer;
  Serializer<Compose> get _composeSerializer =>
      __composeSerializer ??= new ComposeSerializer();
  @override
  Map<String, dynamic> toMap(Building model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(
        ret,
        'constructing',
        codeIterable(model.constructing,
            (val) => _composeSerializer.toMap(val as Compose)));
    setMapValue(
        ret,
        'standing',
        codeIterable(
            model.standing, (val) => _composeSerializer.toMap(val as Compose)));
    setMapValue(
        ret,
        'garrison',
        codeIterable(
            model.garrison, (val) => _composeSerializer.toMap(val as Compose)));
    setMapValue(
        ret,
        'dying',
        codeIterable(
            model.dying, (val) => _composeSerializer.toMap(val as Compose)));
    setMapValue(
        ret,
        'hp25',
        codeIterable(
            model.hp25, (val) => _composeSerializer.toMap(val as Compose)));
    setMapValue(
        ret,
        'hp50',
        codeIterable(
            model.hp50, (val) => _composeSerializer.toMap(val as Compose)));
    setMapValue(
        ret,
        'hp75',
        codeIterable(
            model.hp75, (val) => _composeSerializer.toMap(val as Compose)));
    return ret;
  }

  @override
  Building fromMap(Map map) {
    if (map == null) return null;
    final obj = new Building();
    obj.constructing = codeIterable<Compose>(map['constructing'] as Iterable,
        (val) => _composeSerializer.fromMap(val as Map));
    obj.standing = codeIterable<Compose>(map['standing'] as Iterable,
        (val) => _composeSerializer.fromMap(val as Map));
    obj.garrison = codeIterable<Compose>(map['garrison'] as Iterable,
        (val) => _composeSerializer.fromMap(val as Map));
    obj.dying = codeIterable<Compose>(map['dying'] as Iterable,
        (val) => _composeSerializer.fromMap(val as Map));
    obj.hp25 = codeIterable<Compose>(map['hp25'] as Iterable,
        (val) => _composeSerializer.fromMap(val as Map));
    obj.hp50 = codeIterable<Compose>(map['hp50'] as Iterable,
        (val) => _composeSerializer.fromMap(val as Map));
    obj.hp75 = codeIterable<Compose>(map['hp75'] as Iterable,
        (val) => _composeSerializer.fromMap(val as Map));
    return obj;
  }
}
