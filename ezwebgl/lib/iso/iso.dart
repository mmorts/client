import 'dart:math';
import 'package:ezwebgl/vec/vec.dart';

class Iso {
  final Point<num> orthoSize;
  final Point<num> isoSize;

  Iso._({this.orthoSize, this.isoSize});

  factory Iso.square({double ortho}) {
    if (ortho != null) {
      double width = sqrt(2 * ortho * ortho);
      return Iso._(
          orthoSize: Point<double>(ortho, ortho),
          isoSize: Point<double>(width, width / 2));
    }
    throw Exception("Invalid input!");
  }

  Point<double> tileFromOrtho(Point<num> ortho) {
    double x = (ortho.x - ortho.y) * (orthoSize.x / 2);
    double y = (ortho.x + ortho.y) * (orthoSize.y / 4);
    return Point<double>(x.floorToDouble(), y.floorToDouble());
  }

  Point<double> fromOrtho(Point<num> ortho) {
    double x = (ortho.x - ortho.y) * (orthoSize.x / 2);
    double y = (ortho.x + ortho.y) * (orthoSize.y / 4);
    return Point<double>(x * isoSize.x, y * isoSize.y);
  }

  Point<double> toOrthoTile(Point<num> iso) {
    double y = (iso.x / (isoSize.x / 2) + iso.y / (isoSize.y / 2)) / 2;
    double x = (iso.x / (isoSize.x / 2) - iso.y / (isoSize.y / 2)) / 2;
    return Point<double>(x.floorToDouble(), y.floorToDouble());
  }

  Point<double> toOrtho(Point<num> iso) {
    double y = (iso.x / (isoSize.x / 2) + iso.y / (isoSize.y / 2)) / 2;
    double x = (iso.x / (isoSize.x / 2) - iso.y / (isoSize.y / 2)) / 2;
    return Point<double>(x * orthoSize.x, y * orthoSize.y);
  }
}

Mat4 isometricTransformation(Rectangle rect) {
  final mat = Mat4.identity()
    ..rotateX(pi * (60 / 180))
    ..rotateZ(pi * (-45 / 180));
  return mat;
}
