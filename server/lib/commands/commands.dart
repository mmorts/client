
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
  // TODO
}

class AttackUnit {
  // TODO
}

class AttackBuilding {
  // TODO
}

class BuildBuilding {
  // TODO
}

class RepairBuilding {
  // TODO
}