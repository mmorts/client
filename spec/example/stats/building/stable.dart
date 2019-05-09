import 'ids.dart';

import 'package:spec/stats.dart';

import '../unit/unit.dart';
import '../age.dart';

final lightCavalryResearch =
    Research(0, name: "Light cavalry", cost: Resource(food: 100), effects: []);

final hussarResearch =
    Research(0, name: "Hussar", cost: Resource(food: 100), effects: []);

final cavalierResearch =
    Research(0, name: "Cavalier", cost: Resource(food: 100), effects: []);

final paladinResearch =
    Research(0, name: "Paladin", cost: Resource(food: 100), effects: []);

final stable = Building(
  buildingIdStable,
  name: "Stable",
  shape: RectangleShape(width: 2, height: 2),
  cost: Resource(wood: 150),
  buildTime: 50,
  hp: 1200,
  los: 6,
  pierceArmor: 7,
  garrisonCapacity: 10,
  units: {
    unitIdScoutCavalry: Locked(scoutCavalry, age: feudalAge),
    unitIdLightCavalry:
        Locked(lightCavalry, age: castleAge, research: lightCavalryResearch),
    unitIdHussar: Locked(hussar, age: imperialAge, research: hussarResearch),
    unitIdKnight: Locked(knight, age: castleAge),
    unitIdCavalier:
        Locked(cavalier, age: imperialAge, research: cavalierResearch),
    unitIdPaladin: Locked(paladin, age: imperialAge, research: paladinResearch),
  },
  researches: [
    Locked(lightCavalryResearch, age: castleAge),
    Locked(hussarResearch, age: imperialAge, research: lightCavalryResearch),
    Locked(cavalierResearch, age: imperialAge),
    Locked(paladinResearch, age: imperialAge, research: cavalierResearch),
  ],
);
