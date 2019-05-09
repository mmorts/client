import 'package:meta/meta.dart';

import 'sprite.dart';

/// Specifies unit graphics for a specific state
class UnitState {
  /// The graphics shown when the unit is moving south.
  final List<Layer> s;

  final List<Layer> sw;

  final List<Layer> w;

  final List<Layer> nw;

  final List<Layer> n;

  UnitState({
    @required this.s,
    @required this.sw,
    @required this.w,
    @required this.nw,
    @required this.n,
  });
}

/// Specifies unit graphics
class Unit {
  /// The graphics shown when the unit is moving south.
  final UnitState standing;

  final UnitState walking;

  final UnitState attacking;

  final UnitState dying;

  final UnitState rotting;

  Unit(
      {@required this.standing,
      @required this.walking,
      @required this.attacking,
      @required this.dying,
      @required this.rotting});
}
