import 'dart:math';

export 'package:pos/pos.dart';

class Position2 {
  double x;

  double y;

  Position2({this.x: 0.0, this.y: 0.0});

  Position2 operator +(other) {
    if (other is Position2) {
      return Position2(x: x + other.x, y: y + other.y);
    } else if (other is Point) {
      return Position2(x: x + other.x, y: y + other.y);
    }
    throw Exception("Unknown operand!");
  }

  Position2 clone() => Position2(x: x, y: y);

  Point<double> toPoint() => Point<double>(x, y);

  Point<int> toIntPoint() => Point<int>(x.toInt(), y.toInt());
}

class Position3 implements Position2 {
  double x;

  double y;

  double z;

  Position3({this.x: 0.0, this.y: 0.0, this.z: 0.0});

  Position3 operator +(other) {
    if (other is Position3) {
      return Position3(x: x + other.x, y: y + other.y, z: z + other.z);
    }
    throw Exception("Unknown operand!");
  }

  Position3 clone() => Position3(x: x, y: y, z: z);

  Point<double> toPoint() => Point<double>(x, y);

  Point<int> toIntPoint() => Point<int>(x.toInt(), y.toInt());
}
