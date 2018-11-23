
abstract class Command {
  int get type;
}

class ResearchCommand {
  int buildingId;

  int researchId;

  ResearchCommand({this.buildingId, this.researchId});
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