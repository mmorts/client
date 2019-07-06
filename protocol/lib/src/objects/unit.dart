import 'package:pos/pos.dart';
import 'package:pathing/pathing.dart';

class Military implements Movable {
  final int id;

  // TODO movable stat
  MovableStat stat;

  Position pos;

  // TODO
  int get clan => 1;

  Military(this.id);
}