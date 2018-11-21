// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_graphics.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$SpriteRefSpecSerializer implements Serializer<SpriteRefSpec> {
  final _pointProcessor = const PointProcessor();
  @override
  Map<String, dynamic> toMap(SpriteRefSpec model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'sprite', model.sprite);
    setMapValue(ret, 'offset', _pointProcessor.serialize(model.offset));
    setMapValueIfNotNull(ret, 'loop', model.loop);
    setMapValue(ret, 'rate', model.rate);
    return ret;
  }

  @override
  SpriteRefSpec fromMap(Map map) {
    if (map == null) return null;
    final obj = new SpriteRefSpec(
        sprite: map['sprite'] as String ?? getJserDefault('sprite'),
        offset: _pointProcessor.deserialize(map['offset'] as List) ??
            getJserDefault('offset'),
        loop: map['loop'] as bool ?? getJserDefault('loop'),
        rate: map['rate'] as double ?? getJserDefault('rate'));
    return obj;
  }
}

abstract class _$BuildingLayerSpecSerializer
    implements Serializer<BuildingLayerSpec> {
  final _pointProcessor = const PointProcessor();
  Serializer<SpriteRefSpec> __spriteRefSpecSerializer;
  Serializer<SpriteRefSpec> get _spriteRefSpecSerializer =>
      __spriteRefSpecSerializer ??= new SpriteRefSpecSerializer();
  @override
  Map<String, dynamic> toMap(BuildingLayerSpec model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(
        ret,
        'sprites',
        codeIterable(model.sprites,
            (val) => _spriteRefSpecSerializer.toMap(val as SpriteRefSpec)));
    setMapValue(ret, 'depth', model.depth);
    setMapValue(ret, 'offset', _pointProcessor.serialize(model.offset));
    setMapValue(ret, 'include', model.include);
    setMapValue(ret, 'name', model.name);
    return ret;
  }

  @override
  BuildingLayerSpec fromMap(Map map) {
    if (map == null) return null;
    final obj = new BuildingLayerSpec(
        sprites: codeIterable<SpriteRefSpec>(map['sprites'] as Iterable,
                (val) => _spriteRefSpecSerializer.fromMap(val as Map)) ??
            getJserDefault('sprites'),
        depth: map['depth'] as int ?? getJserDefault('depth'),
        offset: _pointProcessor.deserialize(map['offset'] as List) ??
            getJserDefault('offset'),
        include: map['include'] as String ?? getJserDefault('include'));
    obj.name = map['name'] as String;
    return obj;
  }
}

abstract class _$BuildingGraphicsSpecSerializer
    implements Serializer<BuildingGraphicsSpec> {
  Serializer<BuildingGraphicsStateSpec> __buildingGraphicsStateSpecSerializer;
  Serializer<BuildingGraphicsStateSpec>
      get _buildingGraphicsStateSpecSerializer =>
          __buildingGraphicsStateSpecSerializer ??=
              new BuildingGraphicsStateSpecSerializer();
  @override
  Map<String, dynamic> toMap(BuildingGraphicsSpec model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'constructing',
        _buildingGraphicsStateSpecSerializer.toMap(model.constructing));
    setMapValue(ret, 'standing',
        _buildingGraphicsStateSpecSerializer.toMap(model.standing));
    setMapValue(ret, 'garrison',
        _buildingGraphicsStateSpecSerializer.toMap(model.garrison));
    setMapValue(
        ret, 'dying', _buildingGraphicsStateSpecSerializer.toMap(model.dying));
    setMapValue(ret, 'damage25',
        _buildingGraphicsStateSpecSerializer.toMap(model.damage25));
    setMapValue(ret, 'damage50',
        _buildingGraphicsStateSpecSerializer.toMap(model.damage50));
    setMapValue(ret, 'damage75',
        _buildingGraphicsStateSpecSerializer.toMap(model.damage75));
    return ret;
  }

  @override
  BuildingGraphicsSpec fromMap(Map map) {
    if (map == null) return null;
    final obj = new BuildingGraphicsSpec();
    obj.constructing = _buildingGraphicsStateSpecSerializer
        .fromMap(map['constructing'] as Map);
    obj.standing =
        _buildingGraphicsStateSpecSerializer.fromMap(map['standing'] as Map);
    obj.garrison =
        _buildingGraphicsStateSpecSerializer.fromMap(map['garrison'] as Map);
    obj.dying =
        _buildingGraphicsStateSpecSerializer.fromMap(map['dying'] as Map);
    obj.damage25 =
        _buildingGraphicsStateSpecSerializer.fromMap(map['damage25'] as Map);
    obj.damage50 =
        _buildingGraphicsStateSpecSerializer.fromMap(map['damage50'] as Map);
    obj.damage75 =
        _buildingGraphicsStateSpecSerializer.fromMap(map['damage75'] as Map);
    return obj;
  }
}
