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

  bool operator ==(Object other) {
    if (other is Resource) {
      if (wood != other.wood) return false;
      if (food != other.food) return false;
      if (stone != other.stone) return false;
      if (gold != other.gold) return false;
      return true;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode;

  bool operator <(Resource other) {
    if (wood >= other.wood) return false;
    if (food >= other.food) return false;
    if (stone >= other.stone) return false;
    if (gold >= other.gold) return false;
    return true;
  }

  bool operator <=(Resource other) {
    if (wood > other.wood) return false;
    if (food > other.food) return false;
    if (stone > other.stone) return false;
    if (gold > other.gold) return false;
    return true;
  }

  bool operator >=(Resource other) {
    if (wood < other.wood) return false;
    if (food < other.food) return false;
    if (stone < other.stone) return false;
    if (gold < other.gold) return false;
    return true;
  }

  bool operator >(Resource other) {
    if (wood <= other.wood) return false;
    if (food <= other.food) return false;
    if (stone <= other.stone) return false;
    if (gold <= other.gold) return false;
    return true;
  }
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

class DamageClass {
  final int id;

  final String name;

  DamageClass({this.id, this.name});
}
