import 'package:stats/stats.dart';

const damageIdInfantry = 0;
const damageIdRanged = 1;
const damageIdMountedRanged = 2;
const damageIdGunpowder = 3;
const damageIdMounted = 4;
const damageIdCamel = 5;
const damageIdElephant = 6;
const damageIdSiege = 7;
const damageIdUniqueUnit = 8;

final infantry = DamageClass(id: damageIdInfantry, name: "Infantry");

final ranged = DamageClass(id: damageIdRanged, name: "Ranged");

final mountedRanged = DamageClass(id: damageIdMountedRanged, name: "Mounted ranged");

final gunpowder =
    DamageClass(id: damageIdGunpowder, name: "Gun powder");

final mounted = DamageClass(id: damageIdMounted, name: "Mounted");

final camel = DamageClass(id: damageIdCamel, name: "Camel");

final elephant = DamageClass(id: damageIdElephant, name: "Elephant");

final siege = DamageClass(id: damageIdSiege, name: "Siege");

final uniqueUnit = DamageClass(id: damageIdUniqueUnit, name: "Unique unit");
