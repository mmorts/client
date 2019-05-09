import 'package:meta/meta.dart';
import 'package:client/objects/pos.dart';
import 'package:loader/loader.dart';

import 'package:client/objects/player.dart';

import 'painter.dart';

import 'package:client/objects/data.dart';
import 'package:client/objects/state.dart';

enum BuildingState {
  constructing,
  standing,
  dead,
}

class Building {
  final int id;

  final BuildingPainter painter;

  Player player;

  int hp;

  BuildingState state;

  Position2 pos;

  int stateChangeTime;

  int damageAnimationTime;

  Building(this.id, this.painter, {@required this.pos});

  void paint(State gameState) {
    final spritesForAge = gameState.data.graphics.civs[player.civ]
        .buildings[0 /* TODO */].ages[player.age];
    List<Graphic> sprite;
    if (state == BuildingState.constructing)
      sprite = spritesForAge.constructing;
    else if (state == BuildingState.standing) {
      // TODO hp
      sprite = spritesForAge.standing;
    } else if (state == BuildingState.dead) sprite = spritesForAge.dying;

    painter.paint(
        BuildingPaintData(
            position: pos, previousTime: stateChangeTime, sprites: sprite),
        gameState);
  }
}
