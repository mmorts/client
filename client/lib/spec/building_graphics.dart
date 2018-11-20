import 'dart:math';
import 'package:meta/meta.dart';

class LayerRepo {
  final Map<String, BuildingLayerSpec> layers;

  LayerRepo({this.layers});

  BuildingLayerSpec operator [](int index) => layers[index];
}

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
    return SpriteRefSpec(
      sprite: data["sprite"],
      offset: Point<double>(data["x"].toDouble(), data["y"].toDouble()),
      loop: data["loop"] ?? true,
      rate: data["rate"] ?? 0.0,
    );
  }
}

class BuildingLayerSpec {
  final List<SpriteRefSpec> sprites;
  final int depth;
  BuildingLayerSpec({@required this.sprites, this.depth: 0});
  static Future<BuildingLayerSpec> decode(Map data) async {
    List<Map> spritesRaw = (data["sprite"] as List).cast<Map>();
    final int length = spritesRaw.length;
    final sprites = List<SpriteRefSpec>(length);
    for (int i = 0; i < length; i++) {
      // TODO
      sprites[i] = SpriteRefSpec.decode(spriteRaw);
    }
    // TODO
    return BuildingLayerSpec(
      sprites: sprites,
      depth: data["depth"],
    );
  }
}

class BuildingGraphicsSpec {
  List<BuildingLayerSpec> constructing;
  List<BuildingLayerSpec> standing;
  List<BuildingLayerSpec> garrison;
  List<BuildingLayerSpec> dying;
  Map<int, List<BuildingLayerSpec>> damage;

  BuildingGraphicsSpec(
      {@required this.constructing,
      @required this.standing,
      @required this.garrison,
      @required this.dying,
      @required this.damage});

  static List<BuildingLayerSpec> _parse(List value) {
    // TODO
  }

  static BuildingGraphicsSpec decode(Map data) {
    List<BuildingLayerSpec> standing = _parse(data["standing"]);
    // TODO
    return BuildingGraphicsSpec(standing: standing);
  }
}
