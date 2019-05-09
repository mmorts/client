import 'dart:math';
import 'pos.dart';

enum UnitVerb {
  stand,
  walk,
  attack,
  die,
  rot,
}

class UnitDirection {
  final int id;

  const UnitDirection._(this.id);

  UnitDirection operator+(int op) => map[(id + op) % 8];

  static const s = UnitDirection._(0);
  static const sw = UnitDirection._(1);
  static const w = UnitDirection._(2);
  static const nw = UnitDirection._(3);
  static const n = UnitDirection._(4);
  static const ne = UnitDirection._(5);
  static const e = UnitDirection._(6);
  static const se = UnitDirection._(7);

  static const map = {
    0: s,
    1: sw,
    2: w,
    3: nw,
    4: n,
    5: ne,
    6: e,
    7: se,
  };
}

class UnitState {
  UnitVerb verb;

  UnitDirection dir;

  int since;

  UnitState(
      {this.verb: UnitVerb.stand, this.dir: UnitDirection.s, this.since = 0});
}

class Military {
  Position2 pos = Position2(x: 0.0, y: 0.0);

  final state = UnitState(verb: UnitVerb.stand, dir: UnitDirection.w);

  Military();
}
