import 'package:ezwebgl/ezwebgl.dart';
import 'package:meta/meta.dart';
import 'package:client/objects/objects.dart';

enum BuildingState {
  constructing,
  standing,
  dead,
}

class Building {
  final int id;

  int hp;

  BuildingState state;

  Position2 pos;

  Building(this.id, {@required this.pos});

  void paint(State gameState) {
    /* TODO
    _painter.paint(
        _PaintProps(
            viewport: Rectangle<double>(
              pos.x,
              pos.y - size.y + 22,
              size.x,
              size.y,
            ),
            spriteId: spriteId),
        gameState: gameState);
        */
  }
}
