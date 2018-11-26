import 'dart:html';
import 'package:pathing/pathing.dart';

final map = TileMap(20, 20);

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

  if (t.terrainType & TerrainType.filled != 0) {
    tEl.classes.add("occupied");
  }
}

void drawPath(Path path) {
  viewport.querySelectorAll(".tile.path").forEach((e) => e.remove());

  Path p = path;
  while (p != null) {
    final t = p.tile;
    final tEl = DivElement();
    tEl.classes.addAll(
        ["tile", "tile-${t.flatPos}", "tile-${t.pos.x}-${t.pos.y}", "path"]);
    if (p == path) {
      tEl.classes.add("end");
    }
    if (p.parent == null) {
      tEl.classes.add("start");
    }
    tEl.style.left = "${t.pos.x * 50}px";
    tEl.style.top = "${t.pos.y * 50}px";
    viewport.children.add(tEl);
    p = p.parent;
  }
}

void main() {
  for (Tile t in map.tiles.values) {
    final tEl = DivElement();
    tEl.classes
        .addAll(["tile", "tile-${t.flatPos}", "tile-${t.pos.x}-${t.pos.y}"]);
    tEl.style.left = "${t.pos.x * 50}px";
    tEl.style.top = "${t.pos.y * 50}px";
    viewport.children.add(tEl);
    styleTile(t);

    tEl.onClick.listen((_) {
      t.terrainType ^= 0x1;
      styleTile(t);
    });
  }

  (querySelector("button.find-path") as ButtonElement).onClick.listen((e) {
    Position start = Position(
        x: int.tryParse((querySelector(".startX") as InputElement).value),
        y: int.tryParse((querySelector(".startY") as InputElement).value));
    Position end = Position(
        x: int.tryParse((querySelector(".endX") as InputElement).value),
        y: int.tryParse((querySelector(".endY") as InputElement).value));

    Path path = map.findPath(start, end, TerrainType.land);
    drawPath(path);
  });
}
