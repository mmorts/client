import 'dart:math';
import 'package:client/ezwebgl/ezwebgl.dart';

Mat4 isometricTransformation(Rectangle rect) {
  // return Mat4.identity();
  final mat = Mat4.identity()
    //..translate(x: -rect.left, y: rect.top)
    ..rotateX(pi * (60 / 180))
    ..rotateZ(pi * (-45 / 180))
    // ..translate(x: rect.left, y: rect.top)
  ;
  return mat;
}
