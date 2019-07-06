import 'package:pathing/src/actor/movable.dart';
import 'package:pathing/src/actor/unmovable.dart';
import 'package:pathing/src/formation/formation.dart';

import 'package:pos/pos.dart';

abstract class Pather {
  void addMovable(Movable unit);

  void addMovables(Iterable<Movable> movabs);

  void removeRemovable(/* Movable | String */ unit);

  void addUnmovable(Unmovable unmovable);

  void removeUnmovable(int id);

  void compute();

  void doMovement(Position to, Iterable<int> unitIds, {Formation formation});
}
