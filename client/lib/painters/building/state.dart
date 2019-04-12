import 'package:meta/meta.dart';
import 'package:client/objects/objects.dart';
import 'package:loader/loader.dart';

import 'package:client/objects/player.dart';

import 'painter.dart';
import 'package:client/objects/game.dart';

enum BuildingState {
  constructing,
  standing,
  dead,
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
    painter.paint(
        BuildingPaintData(
            position: pos, previousTime: stateChangeTime, sprites: sprite),
        gameState: gameState);
  }
}
