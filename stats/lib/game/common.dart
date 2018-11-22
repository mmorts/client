part of 'civilization.dart';

class Resource {
  int wood;

  int food;

  int stone;

  int gold;

  Resource(
      {@required this.wood,
        @required this.food,
        @required this.gold,
        @required this.stone});
}

abstract class Shape {}

class CircleShape extends Shape {
  final double radius;

  CircleShape(this.radius);
}

class RectangleShape extends Shape {
  final double width;

  final double height;

  RectangleShape({this.width, this.height});
}

enum AttackType {
  melee,
  ranged,
  mesmerize,
}

class AttackClass {
  final int id;

  final String name;

  AttackClass({this.id, this.name});
}