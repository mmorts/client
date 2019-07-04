import 'movable.dart';
import 'package:pos/pos.dart';
import 'package:pathing/src/movement/movement.dart';

class MovableWrap implements Movable {
  final Movable inner;

  Movement movement;

  MovableWrap(this.inner, {this.movement});

  int get id => inner.id;

  MovableStat get stat => inner.stat;

  int get clan => inner.clan;

  Position get pos => inner.pos;
}