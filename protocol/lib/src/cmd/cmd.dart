import 'package:pos/pos.dart';

abstract class Command {
  int get type;
}

class MoveUnits {
  /// Units by id to move
  final List<int> unitId;

  /// Position to move the units to.
  /// TODO Support multiple points
  final Position pos;
  MoveUnits({this.unitId, this.pos});
}