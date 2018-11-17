import 'dart:math';
import 'package:client/ezwebgl/vec.dart';
import 'package:vector_math/vector_math.dart';

main() {
  final mat = Mat4.identity()
        ..rotateX(pi * (60 / 180))
        ..rotateZ(-pi * (45 / 180))
      // ..rotateX(pi * (35 / 180))
      ;
  print(mat);

  print(mat.dot(Vec4.v(0, 64)));
  print(mat.dot(Vec4.v(64, 0)));
  print(mat.dot(Vec4.v(64, 64)));

  final matinv = mat.inverse();
  print(matinv);

  print(matinv.dot(Vec4.v(45.25483322143555, 64, 22.627416610717773)));
  print(matinv.dot(Vec4.v(45.25483322143555, -22.627416610717773)));
  print(matinv.dot(Vec4.v(90.5096664428711, 0)));
}

/*
[0] 1.0,0.5,-0.28867512941360474,0.0
[1] 0.0,0.7499780058860779,-0.43299999833106995,0.0
[2] 0.0,0.5,0.8660253882408142,0.0
[3] 0.0,0.0,0.0,1.0
 */
