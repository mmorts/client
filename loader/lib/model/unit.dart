import 'package:meta/meta.dart';

import 'sprite.dart';

class UnitState {
  final List<Graphic> s;

  final List<Graphic> sw;

  final List<Graphic> w;

  final List<Graphic> nw;

  final List<Graphic> n;

  UnitState({
    @required this.s,
    @required this.sw,
    @required this.w,
    @required this.nw,
    @required this.n,
  });
}

class Unit {
  UnitState standing;

  UnitState walking;

  UnitState attacking;

  UnitState dying;

  UnitState rotting;

  Unit(
      {@required this.standing,
        @required this.walking,
        @required this.attacking,
        @required this.dying,
        @required this.rotting});
}