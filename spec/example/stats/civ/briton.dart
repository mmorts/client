import 'package:stats/stats.dart';

import '../age.dart';
import '../building/building.dart';

final britons = Civilization(
  name: "Britons",
  startWith: StartWith(villagers: 3),
  ages: [],
  buildings: {
    buildingIdBarrack: Locked(barrack),
    buildingIdArchery: Locked(archery, age: feudalAge),
    buildingIdStable: Locked(stable, age: feudalAge)
  },
  civBonus: [],
  teamBonus: [],
);
