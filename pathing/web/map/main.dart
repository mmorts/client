import 'dart:async';
import 'dart:html';
import 'package:pathing/pathing.dart';

final game = Game();
TileMap get map => game.map;

final viewport = querySelector('#viewport');

void styleTile(Tile t) {
  DivElement tEl = viewport.querySelector(".tile-${t.flatPos}");

  tEl.classes.remove("land");
  tEl.classes.remove("water");
  tEl.classes.remove("occupied");

  if (t.terrainType & TerrainType.land != 0) {
    tEl.classes.add("land");
  } else if (t.terrainType & TerrainType.water != 0) {
    tEl.classes.add("water");
  }

  if (t.owner != null) {
    tEl.classes.add("occupied");
  }
}

void styleUnit(Unit t) {
  DivElement tEl = viewport.querySelector(".unit-${t.id}");
  tEl.style.left = "${t.pos.x * tileSize}px";
  tEl.style.top = "${t.pos.y * tileSize}px";
}

final unitEls = <int, DivElement>{};

int formationIdGen = 0;

final int tileSize = 5;

void main() {
  Player player1 = Player(1, game);
  game.players[player1.id] = player1;

  Unit unit1 = game.players[1].addUnit(pos: Position(x: 0, y: 0));
  Unit unit2 = game.players[1].addUnit(pos: Position(x: 1, y: 0));

  for (Tile t in map.tiles.values) {
    final tEl = DivElement();
    tEl.classes
        .addAll(["tile", "tile-${t.flatPos}", "tile-${t.pos.x}-${t.pos.y}"]);
    tEl.style.width = "${tileSize}px";
    tEl.style.height = "${tileSize}px";
    tEl.style.left = "${t.pos.x * tileSize}px";
    tEl.style.top = "${t.pos.y * tileSize}px";
    viewport.children.add(tEl);
    styleTile(t);

    tEl.onClick.listen((MouseEvent event) {
      event.preventDefault();
      if (event.button == 0) {
        if(t.owner == null) t.owner = 'x';
        else if(t.owner == 'x') t.owner = null;
        styleTile(t);
      }
    });
    tEl.onContextMenu.listen((MouseEvent event) {
      if (event.ctrlKey) return;
      event.preventDefault();
      final int id = formationIdGen++;
      game.players[1].formations[id] = Movement(id, map, t.pos, [unit1, unit2]);
    });
  }

  Timer.periodic(Duration(milliseconds: 500), (_) {
    game.compute();

    for (Unit unit in game.units.values) {
      DivElement unitEl = unitEls[unit.id];
      if (unitEl == null) {
        unitEl = DivElement();
        unitEl.text = unit.id.toString();
        unitEl.classes
            .addAll(["unit", "unit-${unit.id}", "unit-pl${unit.player.id}"]);
        unitEl.style.width = "${tileSize}px";
        unitEl.style.height = "${tileSize}px";
        unitEls[unit.id] = unitEl;
        viewport.children.add(unitEl);
      }

      styleUnit(unit);
    }
  });
}
