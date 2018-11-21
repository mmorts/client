import 'package:ezwebgl/ezwebgl.dart';
import 'package:meta/meta.dart';
import 'package:client/objects/objects.dart';
import 'package:loader/loader.dart';

import 'painter.dart';
import 'sprite.dart';

enum BuildingState {
  constructing,
  standing,
  dead,
}

class Player {
  final int id;

  final int civ;

  int age;

  Player(this.id, this.civ, {this.age});
}

class SpriteRepo {
  final List<BuildingSprite> buildings;

  SpriteRepo({this.buildings});
}

class Game {
  final SpriteRepo spriteRepo;

  Game({this.spriteRepo});
}

class Building {
  final int id;

  final Game game;

  final BuildingPainter painter;

  Player player;

  int hp;

  BuildingState state;

  Position2 pos;

  int stateChangeTime;

  int damageAnimationTime;

  Building(this.game, this.id, this.painter, {@required this.pos});

  void paint(State gameState) {
    final spritesForAge = game
        .spriteRepo.buildings[id].civilizations[player.civ].ages[player.age];
    List<SpriteRef> sprite;
    if (state == BuildingState.constructing)
      sprite = spritesForAge.constructing;
    if (state == BuildingState.standing) sprite = spritesForAge.standing;
    if (state == BuildingState.dead) sprite = spritesForAge.dying;
    painter.paintBuilding(
        BuildingPaintData(
            position: pos, previousTime: stateChangeTime, sprites: sprite),
        gameState: gameState);
  }
}
