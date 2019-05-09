import 'dart:io';
import 'dart:math';
import 'package:spec/graphics.dart';

final barrack = Building(
  standing: [
    Layer(
      sprites: [
        Compose(
          sprite: Sprite(
            frames: [
              Frame(hotspot: Point(149, 185)),
            ],
          ),
        ),
      ],
    ),
  ],
);

final militia = Unit(
  standing: UnitState(s: [], sw: [], w: [], nw: [], n: []),
  walking: UnitState(s: [], sw: [], w: [], nw: [], n: []),
);

main() async {
  // Something here
}
