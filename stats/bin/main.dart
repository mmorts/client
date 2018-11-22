import 'package:stats/stats.dart';

final britons = CivilizationStat(
  name: "Britons",
  ages: [
    /*
    CivAge(buildings: [
      // Building(name: "Barrack", units: [Unit()]),
      // TODO
    ]),
    */
  ],
);

final game =
    GameStat(civs: [britons], ages: ["Dark", "Feudal", "Castle", "Imperial"]);
