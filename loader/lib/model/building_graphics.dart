import 'sprite_ref.dart';

class BuildingSpriteAge {
  final List<SpriteRef> constructing;
  final List<SpriteRef> standing;
  final List<SpriteRef> garrison;
  final List<SpriteRef> dying;
  final List<SpriteRef> damage25;
  final List<SpriteRef> damage50;
  final List<SpriteRef> damage75;

  BuildingSpriteAge(
      {this.constructing,
        this.standing,
        this.garrison,
        this.dying,
        this.damage25,
        this.damage50,
        this.damage75});
}

class BuildingSpriteCiv {
  final List<BuildingSpriteAge> ages;

  BuildingSpriteCiv({this.ages});
}

class BuildingSprite {
  final List<BuildingSpriteCiv> civilizations;

  BuildingSprite({this.civilizations});
}