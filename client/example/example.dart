import 'dart:math';
import 'package:client/ezwebgl/vec.dart';
import 'package:vector_math/vector_math.dart';

main() {
  final mat = Mat4.identity()
        ..rotateX(pi * (30 / 180))
        ..rotateZ(pi * (45 / 180))
      // ..rotateX(pi * (35 / 180))
      ;
  print(mat);

  final mat2 = Matrix4.identity()
    ..rotateX(pi * (30 / 180))
    ..rotateZ(pi * (45 / 180));
  print(mat2);
}

/*
[0] 1.0,0.5,-0.28867512941360474,0.0
[1] 0.0,0.7499780058860779,-0.43299999833106995,0.0
[2] 0.0,0.5,0.8660253882408142,0.0
[3] 0.0,0.0,0.0,1.0
 */
