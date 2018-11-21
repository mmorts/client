import 'dart:math';
import 'package:jaguar_serializer/jaguar_serializer.dart';

class PointProcessor implements FieldProcessor<Point<double>, List> {
  const PointProcessor();

  @override
  Point<double> deserialize(List value) {
    if (value == null) return null;
    return Point<double>(value[0].toDouble(), value[1].toDouble());
  }

  @override
  List<double> serialize(Point<double> value) {
    if (value == null) return null;
    return [value.x, value.y];
  }
}