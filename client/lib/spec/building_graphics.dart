import 'dart:math';
import 'package:meta/meta.dart';

class SpriteRefSpec {
  final String sprite;

  final Point<double> offset;

  final bool loop;

  final int rate;

  SpriteRefSpec(
      {@required this.sprite,
      @required this.offset,
      @required this.loop,
      @required this.rate});

  static SpriteRefSpec decode(Map data) {
    List<num> offset = ((data["offset"] as List) ?? [0, 0]).cast<num>();
    return SpriteRefSpec(
      sprite: data["sprite"],
      offset: Point<double>(offset[0].toDouble(), offset[1].toDouble()),
      loop: data["loop"] ?? true,
      rate: data["rate"] ?? 0.0,
    );
  }
}

class BuildingLayerSpec {
  final List<SpriteRefSpec> sprites;
  final int depth;
  final Point<double> offset;
  final String include;
  BuildingLayerSpec(
      {@required this.sprites,
      this.depth: 0,
      this.offset: const Point<double>(0, 0),
      this.include});
  static BuildingLayerSpec decode(Map data) {
    List<Map> spritesRaw = (data["sprites"] as List).cast<Map>();
    final int length = spritesRaw.length;
    final sprites = List<SpriteRefSpec>(length);
    for (int i = 0; i < length; i++) {
      sprites[i] = SpriteRefSpec.decode(spritesRaw[i]);
    }
    List<num> offset = ((data["offset"] as List) ?? [0, 0]).cast<num>();
    return BuildingLayerSpec(
        sprites: sprites,
        depth: data["depth"] ?? 0,
        offset: Point<double>(offset[0].toDouble(), offset[1].toDouble()),
        include: data['include']);
  }
}

class BuildingGraphicsStateSpec {
  List<BuildingLayerSpec> layers;

  BuildingGraphicsStateSpec({this.layers});

  static BuildingGraphicsStateSpec decode(Map data) {
    if (data == null) return BuildingGraphicsStateSpec(layers: []);

    final layers = <BuildingLayerSpec>[];

    for (String key in data.keys) {
      if (key == "") {
        // Dummy!
        continue;
      } else {
        layers.add(BuildingLayerSpec.decode(data));
      }
    }

    return BuildingGraphicsStateSpec(layers: layers);
  }
}

class BuildingGraphicsSpec {
  // The graphics shown during construction.
  BuildingGraphicsStateSpec constructing;
  // The graphics shown normally
  BuildingGraphicsStateSpec standing;
  // The overlay graphics displayed when garrisoned.
  BuildingGraphicsStateSpec garrison;
  // The graphics shown when dying.
  BuildingGraphicsStateSpec dying;
  Map<int, BuildingGraphicsStateSpec> damage;

  BuildingGraphicsSpec(
      {@required this.constructing,
      @required this.standing,
      @required this.garrison,
      @required this.dying,
      @required this.damage});

  static BuildingGraphicsSpec decode(Map data) {
    return BuildingGraphicsSpec(
        constructing: BuildingGraphicsStateSpec.decode(data["constructing"]),
        standing: BuildingGraphicsStateSpec.decode(data["standing"]),
        garrison: BuildingGraphicsStateSpec.decode(data["garrison"]),
        dying: BuildingGraphicsStateSpec.decode(data["dying"]));
  }
}
