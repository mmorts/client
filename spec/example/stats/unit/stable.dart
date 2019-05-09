import 'ids.dart';

import 'package:spec/stats.dart';
import '../damage_class.dart';

final scoutCavalry = Unit(
  unitIdScoutCavalry,
  name: "Scout cavalry",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [mounted],
  cost: Resource(food: 60),
  trainTime: 10,
  speed: 1.2,
  los: 6,
  hp: 60,
  attack: 6,
  armor: 1,
  pierceArmor: 1,
  attackRate: 1,
  attackBonus: {},
);

final lightCavalry = Unit(
  unitIdLightCavalry,
  name: "Light cavalry",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [mounted],
  cost: Resource(food: 60),
  trainTime: 10,
  speed: 1.2,
  los: 6,
  hp: 60,
  attack: 6,
  armor: 1,
  pierceArmor: 1,
  attackRate: 1,
  attackBonus: {},
);

final hussar = Unit(
  unitIdHussar,
  name: "Hussar",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [mounted],
  cost: Resource(food: 60),
  trainTime: 10,
  speed: 1.2,
  los: 6,
  hp: 60,
  attack: 6,
  armor: 1,
  pierceArmor: 1,
  attackRate: 1,
  attackBonus: {},
);

final knight = Unit(
  unitIdKnight,
  name: "Knight",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [mounted],
  cost: Resource(food: 60),
  trainTime: 10,
  speed: 1.2,
  los: 6,
  hp: 60,
  attack: 6,
  armor: 1,
  pierceArmor: 1,
  attackRate: 1,
  attackBonus: {},
);

final cavalier = Unit(
  unitIdCavalier,
  name: "Cavalier",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [mounted],
  cost: Resource(food: 60),
  trainTime: 10,
  speed: 1.2,
  los: 6,
  hp: 60,
  attack: 6,
  armor: 1,
  pierceArmor: 1,
  attackRate: 1,
  attackBonus: {},
);

final paladin = Unit(
  unitIdPaladin,
  name: "Paladin",
  shape: CircleShape(1),
  attackType: AttackType.melee,
  damageClass: [mounted],
  cost: Resource(food: 60),
  trainTime: 10,
  speed: 1.2,
  los: 6,
  hp: 60,
  attack: 6,
  armor: 1,
  pierceArmor: 1,
  attackRate: 1,
  attackBonus: {},
);