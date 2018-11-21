import 'package:ezwebgl/ezwebgl.dart';
import 'package:meta/meta.dart';
import 'package:client/objects/objects.dart';

class BuildingPaintState {
  // TODO
}

class Building {
  Position2 pos;

  int spriteId;

  Building({@required this.pos, @required this.spriteId}) {}

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