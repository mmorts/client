import 'dart:async';
import 'dart:html';
import 'package:pathing/pathing.dart';
import 'package:pathing/src/actor/actor.dart';

final game = Pather();

final unitEls = <int, DivElement>{};

int actorIdGen = 0;

final int tileSize = 25;

final selected = Map<int, Movable>();

final militia = MovableStat(1,
    size: Point<int>(1, 1), formationRole: FormationRole.protector, speed: 5);

final tree = UnmovableStat(2, size: Point<int>(1, 1));

final unmovables = <Element, Unmovable>{};

final viewport = querySelector('#viewport');

void styleTile(Tile t) {
  DivElement tEl = viewport.querySelector(".tile-${t.flatPos}");

  tEl.classes.remove("land");
  tEl.classes.remove("water");

  if (t.terrainType & TerrainType.land != 0) {
    tEl.classes.add("land");
  } else if (t.terrainType & TerrainType.water != 0) {
    tEl.classes.add("water");
  }
}

void styleUnit(Movable t) {
  DivElement tEl = viewport.querySelector(".unit-${t.id}");
  tEl.style.left = "${t.pos.x * tileSize}px";
  tEl.style.top = "${t.pos.y * tileSize}px";

  tEl.classes.remove("selected");
  if (selected.containsKey(t.id)) {
    tEl.classes.add("selected");
  }
}

class MoveableImpl implements Movable {
  final int id;

  MovableStat stat;

  final int clan;

  Position pos;

  Movement movement;

  MoveableImpl(this.id, this.stat, {this.clan, this.pos, this.movement});
}

class UnmovableImpl implements Unmovable {
  final int id;

  UnmovableStat stat;

  Position pos;

  UnmovableImpl(this.id, {this.stat, this.pos});
}

void main() {
  final unit1 = MoveableImpl(1, militia, pos: Position(x: 10, y: 5), clan: 1);
  final unit2 = MoveableImpl(2, militia, pos: Position(x: 11, y: 5), clan: 1);
  final Movable unit3 =
      MoveableImpl(3, militia, pos: Position(x: 12, y: 5), clan: 1);
  final Movable unit4 =
      MoveableImpl(4, militia, pos: Position(x: 13, y: 5), clan: 1);
  final Movable unit5 =
      MoveableImpl(5, militia, pos: Position(x: 14, y: 5), clan: 1);
  final Movable unit6 =
      MoveableImpl(6, militia, pos: Position(x: 15, y: 5), clan: 1);
  final Movable unit7 =
      MoveableImpl(7, militia, pos: Position(x: 16, y: 5), clan: 1);
  final Movable unit8 =
      MoveableImpl(8, militia, pos: Position(x: 17, y: 5), clan: 1);
  final Movable unit9 =
      MoveableImpl(9, militia, pos: Position(x: 18, y: 5), clan: 1);
  final Movable unit10 =
      MoveableImpl(10, militia, pos: Position(x: 41, y: 5), clan: 1);
  actorIdGen = 11;
  game.addMovables(
      [unit1, unit2, unit3, unit4, unit5, unit6, unit7, unit8, unit9, unit10]);

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

  for (Tile t in game.map.tiles.values) {
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
        if (t.owner == null) {
          final unmovable =
              UnmovableImpl(actorIdGen++, stat: tree, pos: t.pos.clone());
          final el = DivElement();
          unmovables[el] = unmovable;
          game.addUnmovable(unmovable);
          viewport.children.add(el);

          el.onClick.listen((MouseEvent event) {
            unmovables.remove(el);
            game.removeUnmovable(unmovable.id);
          });
        }
      }
    });

    tEl.onContextMenu.listen((MouseEvent event) {
      if (event.ctrlKey) return;
      event.preventDefault();

      game.addMovementWithFormation(t.pos, selected.values.map((u) => u.id),
          formation: LineFormation());
      // NoFormationMovement(id, map, t.pos, selected.values);
    });
  }

  Timer.periodic(Duration(milliseconds: 100), (_) {
    final watch = Stopwatch();
    watch.start();
    print("s");
    game.compute();

    for (Movable unit in game.movable.values) {
      DivElement unitEl = unitEls[unit.id];
      if (unitEl == null) {
        unitEl = DivElement();
        unitEl.text = unit.id.toString();
        unitEl.classes
            .addAll(["unit", "unit-${unit.id}", "unit-pl${unit.clan}"]);
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

      watch.stop();
      if (watch.elapsedMilliseconds > 100)
        print(watch.elapsedMilliseconds ~/ 100);

      styleUnit(unit);
    }

    for (Element unmoveEl in unmovables.keys) {
      final unmovable = unmovables[unmoveEl];

      unmoveEl.classes.add('unmovable');

      unmoveEl.style.left = "${unmovable.pos.x * tileSize}px";
      unmoveEl.style.top = "${unmovable.pos.y * tileSize}px";

      unmoveEl.style.width = "${unmovable.stat.size.x * tileSize}px";
      unmoveEl.style.height = "${unmovable.stat.size.y * tileSize}px";
    }
  });
}
