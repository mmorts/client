import 'ids.dart';

import 'package:stats/stats.dart';

import '../unit/unit.dart';

final crossbowmanResearch =
    Research(0, name: "Crossbowman", cost: Resource(food: 100), effects: []);

final arbalestResearch =
    Research(0, name: "Arbalest", cost: Resource(food: 100), effects: []);

final archery = Building(
  buildingIdArchery,
  name: "Archery",
  shape: RectangleShape(width: 2, height: 2),
  cost: Resource(wood: 175),
  buildTime: 50,
  hp: 1200,
  los: 6,
  pierceArmor: 7,
  garrisonCapacity: 10,
  units: {
    unitIdArcher: Locked(archer, age: 2),
    unitIdCrossbowman:
        Locked(crossbowman, age: 2, research: crossbowmanResearch),
    unitIdArbalest: Locked(arbalest, age: 3, research: arbalestResearch),
  },
  researches: [
    Locked(crossbowmanResearch, age: 2),
    Locked(arbalestResearch, age: 3, research: crossbowmanResearch),
  ],
);
