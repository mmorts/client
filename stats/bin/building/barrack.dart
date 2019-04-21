import 'ids.dart';

import 'package:stats/stats.dart';

import '../unit/unit.dart';

final manAtArmsResearch =
    Research(0, name: "Man-at-Arms", cost: Resource(food: 100), effects: []);

final longSwordsmanResearch =
    Research(0, name: "Long swordsman", cost: Resource(food: 100), effects: []);

final twoHandedSwordsmanResearch = Research(0,
    name: "Two handed swordsman", cost: Resource(food: 100), effects: []);

final championResearch =
    Research(0, name: "Champion", cost: Resource(food: 100), effects: []);

// TODO arson

final barrack = Building(
  buildingIdBarrack,
  name: "Barrack",
  shape: RectangleShape(width: 2, height: 2),
  cost: Resource(wood: 150),
  buildTime: 50,
  hp: 1200,
  los: 6,
  pierceArmor: 7,
  garrisonCapacity: 10,
  units: {
    unitIdMilitia: Locked(militia),
    unitIdManAtArms: Locked(manAtArms, age: 1, research: manAtArmsResearch),
    unitIdLongSwordsman:
        Locked(longSwordsman, age: 2, research: longSwordsmanResearch),
    unitIdTwoHandedSwordsman: Locked(twoHandedSwordsman,
        age: 3, research: twoHandedSwordsmanResearch),
    unitIdChampion: Locked(champion, age: 3, research: championResearch),
  },
  researches: [
    Locked(manAtArmsResearch, age: 1),
    Locked(longSwordsmanResearch, age: 2, research: manAtArmsResearch),
    Locked(twoHandedSwordsmanResearch, age: 3, research: longSwordsmanResearch),
    Locked(championResearch, age: 3, research: twoHandedSwordsmanResearch),
  ],
);
