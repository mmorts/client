import 'ids.dart';

import 'package:stats/stats.dart';
import '../damage_class.dart';

final archer = Unit(
  unitIdArcher,
  name: "Archer",
  shape: CircleShape(1),
  attackType: AttackType.pierce,
  damageClass: [ranged],
  cost: Resource(food: 30, gold: 30),
  trainTime: 10,
  speed: 1.1,
  los: 6,
  hp: 30,
  attack: 7,
  attackRate: 1,
  attackBonus: {},
  range: Range(min: 1, max: 6),
  accuracy: 60,
);

final crossbowman = Unit(
  unitIdCrossbowman,
  name: "Crossbowman",
  shape: CircleShape(1),
  attackType: AttackType.pierce,
  damageClass: [ranged],
  cost: Resource(food: 30, gold: 30),
  trainTime: 10,
  speed: 1.1,
  los: 6,
  hp: 30,
  attack: 7,
  attackRate: 1,
  attackBonus: {},
  range: Range(min: 1, max: 6),
  accuracy: 60,
);

final arbalest = Unit(
  unitIdArbalest,
  name: "Arbalest",
  shape: CircleShape(1),
  attackType: AttackType.pierce,
  damageClass: [ranged],
  cost: Resource(food: 30, gold: 30),
  trainTime: 10,
  speed: 1.1,
  los: 6,
  hp: 30,
  attack: 7,
  attackRate: 1,
  attackBonus: {},
  range: Range(min: 1, max: 6),
  accuracy: 60,
);

final skirmisher = Unit(
  unitIdSkirmisher,
  name: "Skirmisher",
  shape: CircleShape(1),
  attackType: AttackType.pierce,
  damageClass: [ranged],
  cost: Resource(wood: 30, gold: 30),
  trainTime: 10,
  speed: 1.1,
  los: 6,
  hp: 25,
  attack: 3,
  pierceArmor: 3,
  attackRate: 1,
  attackBonus: {
    ranged: 3,
  },
  range: Range(min: 2, max: 6),
  accuracy: 60,
);

final eliteSkirmisher = Unit(
  unitIdEliteSkirmisher,
  name: "Elite Skirmisher",
  shape: CircleShape(1),
  attackType: AttackType.pierce,
  damageClass: [ranged],
  cost: Resource(wood: 30, gold: 30),
  trainTime: 10,
  speed: 1.1,
  los: 6,
  hp: 25,
  attack: 3,
  pierceArmor: 3,
  attackRate: 1,
  attackBonus: {
    ranged: 3,
  },
  range: Range(min: 2, max: 6),
  accuracy: 60,
);