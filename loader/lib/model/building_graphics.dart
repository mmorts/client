import 'sprite_ref.dart';

class BuildingSpriteForAge {
  final List<SpriteRef> constructing;
  final List<SpriteRef> standing;
  final List<SpriteRef> garrison;
  final List<SpriteRef> dying;
  final List<SpriteRef> damage25;
  final List<SpriteRef> damage50;
  final List<SpriteRef> damage75;

  BuildingSpriteForAge(
      {this.constructing,
      this.standing,
      this.garrison,
      this.dying,
      this.damage25,
      this.damage50,
      this.damage75});
}

class BuildingSpriteForCiv {
  final BuildingSpriteForAge age0;
  final BuildingSpriteForAge age1;
  final BuildingSpriteForAge age2;
  final BuildingSpriteForAge age3;

  List<BuildingSpriteForAge> get ages => [age0, age1, age2, age3];

  BuildingSpriteForCiv({this.age0, this.age1, this.age2, this.age3});
}

class BuildingSprite {
  final List<BuildingSpriteForCiv> civilizations;

  BuildingSprite({this.civilizations});
}
