import 'dart:io';
import 'package:spec/spec.dart';

final barrack = Building(
  standing: [
    Layer(
      sprites: [
        Compose(
          sprite: Sprite(
            frames: [
              Frame(),
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
