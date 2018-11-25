import 'package:server/spatial/tile.dart';

abstract class Command {
  int get type;
}

class ResearchCommand {
  final int buildingId;

  final int researchId;

  ResearchCommand({this.buildingId, this.researchId});
}

class RecruitVillager {
  final int buildingId;

  final int amount;

  RecruitVillager({this.buildingId, this.amount});
}

class RecruitArmy {
  final int buildingId;

  final int unitId;

  final int amount;

  RecruitArmy({this.buildingId, this.unitId, this.amount});
}

class MoveUnits {
  final List<int> unitId;
  final Position pos;
  MoveUnits({this.unitId, this.pos});
}

class AttackUnit {
  // TODO
}

class AttackBuilding {
  // TODO
}

class AttackGround {
  // TODO
}

class BuildBuilding {
  // TODO
}

class RepairBuilding {
  // TODO
}

class ChopWood {
  // TODO
}

class Forage {
  // TODO
}

class Farm {
  // TODO
}

class Hunt {
  // TODO
}

class MineStone {
  // TODO
}

class MineGold {
  // TODO
}