import 'package:loader/loader.dart';

final britons = Civilization(
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
    Game(civs: [britons], ages: ["Dark", "Feudal", "Castle", "Imperial"]);
