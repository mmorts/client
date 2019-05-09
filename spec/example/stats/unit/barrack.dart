import 'ids.dart';

import 'package:stats/stats.dart';
import '../damage_class.dart';

final militia = Unit(
  unitIdMilitia,
  name: "Militia",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [infantry],
  cost: Resource(food: 60, gold: 20),
  trainTime: 10,
  speed: 1.1,
  los: 6,
  hp: 60,
  attack: 9,
  attackRate: 1,
  attackBonus: {},
);

final manAtArms = Unit(
  unitIdManAtArms,
  name: "Man-at-Arms",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [infantry],
  cost: Resource(food: 60, gold: 20),
  trainTime: 10,
  speed: 1.1,
  los: 6,
  hp: 70,
  attack: 9,
  armor: 1,
  attackRate: 1,
  attackBonus: {},
);

final longSwordsman = Unit(
  unitIdLongSwordsman,
  name: "Long swordsman",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [infantry],
  cost: Resource(food: 60, gold: 20),
  trainTime: 10,
  speed: 1.1,
  los: 6,
  hp: 70,
  attack: 9,
  armor: 1,
  attackRate: 1,
  attackBonus: {},
);

final twoHandedSwordsman = Unit(
  unitIdTwoHandedSwordsman,
  name: "Two handed swordsman",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [infantry],
  cost: Resource(food: 60, gold: 20),
  trainTime: 10,
  speed: 1.1,
  los: 6,
  hp: 70,
  attack: 9,
  armor: 1,
  attackRate: 1,
  attackBonus: {},
);

final champion = Unit(
  unitIdChampion,
  name: "Champion",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [infantry],
  cost: Resource(food: 60, gold: 20),
  trainTime: 10,
  speed: 1.1,
  los: 6,
  hp: 70,
  attack: 9,
  armor: 1,
  attackRate: 1,
  attackBonus: {},
);
