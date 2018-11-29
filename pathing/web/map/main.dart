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

  tEl.classes.remove("selected");
  if (selected.containsKey(t.id)) {
    tEl.classes.add("selected");
  }
}

final unitEls = <int, DivElement>{};

int formationIdGen = 0;

final int tileSize = 25;

int curPlayer = 1;

final selected = Map<int, Unit>();

void main() {
  Player player1 = Player(1, game);
  game.players[player1.id] = player1;

  Unit unit1 = game.players[1].addUnit(pos: Position(x: 0, y: 0));
  Unit unit2 = game.players[1].addUnit(pos: Position(x: 1, y: 0));
  Unit unit3 = game.players[1].addUnit(pos: Position(x: 2, y: 0));
  Unit unit4 = game.players[1].addUnit(pos: Position(x: 3, y: 0));
  Unit unit5 = game.players[1].addUnit(pos: Position(x: 4, y: 0));
  Unit unit6 = game.players[1].addUnit(pos: Position(x: 5, y: 0));
  Unit unit7 = game.players[1].addUnit(pos: Position(x: 6, y: 0));
  Unit unit8 = game.players[1].addUnit(pos: Position(x: 7, y: 0));
  Unit unit9 = game.players[1].addUnit(pos: Position(x: 8, y: 0));
  Unit unit10 = game.players[1].addUnit(pos: Position(x: 9, y: 0));

  selected[unit1.id] = unit1;
  selected[unit2.id] = unit2;
  selected[unit3.id] = unit3;
  selected[unit4.id] = unit4;
  selected[unit5.id] = unit5;
  selected[unit6.id] = unit6;
  selected[unit7.id] = unit7;
  selected[unit8.id] = unit8;
  selected[unit9.id] = unit9;
  selected[unit10.id] = unit10;

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
        if (t.owner == null)
          t.owner = 'x';
        else if (t.owner == 'x') t.owner = null;
        styleTile(t);
      }
    });
    tEl.onContextMenu.listen((MouseEvent event) {
      if (event.ctrlKey) return;
      event.preventDefault();
      final int id = formationIdGen++;
      game.players[1].formations[id] =
          Movement(id, map, t.pos, selected.values);
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

        unitEl.onClick.listen((e) {
          if (e.shiftKey) {
            if (selected.containsKey(unit.id)) {
              selected.remove(unit.id);
            } else {
              selected[unit.id] = unit;
            }
          } else {
            selected.clear();
            selected[unit.id] = unit;
          }
        });
      }

      styleUnit(unit);
    }
  });
}
