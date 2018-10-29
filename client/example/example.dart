import 'dart:math';
import 'package:vector_math/vector_math.dart';

main() {
  /*
  final mat = Matrix4.identity()
    ..scale(1.0, 0.866)
    ..multiply(Matrix4.skewX(pi / 6))
    ..rotateX(pi / 6);
    */
  final mat = Matrix4.identity()..rotateZ(pi * (-45 / 180))
      // ..rotateX(pi * (35 / 180))
      ;
  print(mat);
}

/*
[0] 1.0,0.5,-0.28867512941360474,0.0
[1] 0.0,0.7499780058860779,-0.43299999833106995,0.0
[2] 0.0,0.5,0.8660253882408142,0.0
[3] 0.0,0.0,0.0,1.0
 */
