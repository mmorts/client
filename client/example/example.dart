import 'package:vector_math/vector_math.dart';

main() {
  final mat = Matrix4.identity()
    ..rotateX(45.0)
    ..rotateY(45.0);
  print(mat);
}
