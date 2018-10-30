part of 'ezwebgl.dart';

abstract class BufData {
  List<Vec> get asGlData;
}

class PosBuf implements BufData {
  final Vec4 position;

  PosBuf({@required this.position});

  @override
  List<Vec> get asGlData {
    return [position];
  }

  static void setupAttributes(ShaderProgram program,
      {String posName = "position"}) {
    program.addAttribute(posName, size: 4);
  }

  static Buffer createBuffer(ShaderProgram program) {
    Buffer buffer = program.gl.createBuffer();
    program.gl.bindBuffer(WebGL.ARRAY_BUFFER, buffer);
    setupAttributes(program);

    return buffer;
  }
}

class TexBuf implements BufData {
  final Vec4 texCoords;

  TexBuf({@required this.texCoords});

  @override
  List<Vec> get asGlData {
    return [texCoords];
  }

  static void setupAttributes(ShaderProgram program,
      {String texCoordName = "texcoord"}) {
    program.addAttribute(texCoordName, size: 4);
  }

  static Buffer createBuffer(ShaderProgram program,
      {String texCoordName = "texcoord"}) {
    Buffer buffer = program.gl.createBuffer();
    program.gl.bindBuffer(WebGL.ARRAY_BUFFER, buffer);
    setupAttributes(program, texCoordName: texCoordName);

    return buffer;
  }
}

class PosTexBuf implements BufData {
  final Vec4 position;

  final Vec2 texCoords;

  PosTexBuf({@required this.position, @required this.texCoords});

  @override
  List<Vec> get asGlData {
    return [position, texCoords];
  }

  static void setupAttributes(ShaderProgram program,
      {String posName = "position", String texCoordName = "texcoord"}) {
    program.addAttribute(posName, size: 4, stride: 6 * 4);
    program.addAttribute(texCoordName, size: 2, stride: 6 * 4, offset: 4 * 4);
  }

  static Buffer createBuffer(ShaderProgram program,
      {String posName = "position", String texCoordName = "texcoord"}) {
    Buffer buffer = program.gl.createBuffer();
    program.gl.bindBuffer(WebGL.ARRAY_BUFFER, buffer);
    setupAttributes(program, posName: posName, texCoordName: texCoordName);

    return buffer;
  }
}

class VecArray<V extends Vec> {
  final elements = List<V>();

  int get length => elements.length;

  V operator [](int index) => elements[index];

  void operator []=(int index, V value) => elements[index] = value;

  Float32List toBuffer() {
    int x = 0;
    if (length != 0) {
      x = elements.first.count;
    }

    final ret = Float32List(length * x);

    for (int i = 0; i < length; i++) {
      int ii = i * x;
      for (int j = 0; j < x; j++) {
        ret[ii + j] = elements[i][j];
      }
    }

    return ret;
  }

  void add(V value) => elements.add(value);
}

class DataArray<V extends BufData> {
  final elements = List<V>();

  int get length => elements.length;

  V operator [](int index) => elements[index];

  void operator []=(int index, V value) => elements[index] = value;

  Float32List toBuffer() {
    int stride = 0;
    if (length != 0) {
      stride = elements.first.asGlData.fold(0, (v, vec) => v + vec.count);
    }

    final ret = Float32List(length * stride);

    for (int i = 0; i < length; i++) {
      int rowStart = i * stride;
      List<Vec> vecs = elements[i].asGlData;
      List<double> data = vecs.first.values;
      int vecIndex = 1;
      int dataIndex = 0;
      for (int j = 0; j < stride; j++) {
        if (dataIndex == data.length) {
          data = vecs[vecIndex++].values;
          dataIndex = 0;
        }
        ret[rowStart + j] = data[dataIndex++];
      }
    }

    return ret;
  }

  void add(BufData data) {
    elements.add(data);
  }

  /// Sends data to GPU
  ///
  /// [buffer] specifies which WebGL buffer shall be used to send data.
  void drawArrays(
      {@required RenderingContext2 gl,
      @required Buffer buffer,
      int usage: WebGL.STATIC_DRAW,
      int mode: WebGL.TRIANGLES,
      int offset: 0}) {
    gl.bindBuffer(WebGL.ARRAY_BUFFER, buffer);
    gl.bufferData(WebGL.ARRAY_BUFFER, toBuffer(), usage);
    gl.drawArrays(mode, offset, length);
  }
}

abstract class Vec {
  int get count;

  List<double> get values;

  double operator [](int index);

  void operator []=(int index, double value);
}

abstract class _VecMixin implements Vec {
  void assign(dynamic /* Iterable<double> | Vec */ value) {
    if (value is Vector) {
      value = (value as Vector).storage;
    }
    if (value is Iterable<double>) {
      int max = math.min(value.length, count);
      for (int i = 0; i < max; i++) {
        this[i] = value.elementAt(i);
      }
    } else if (value is Vec) {
      int max = math.min(value.count, count);
      for (int i = 0; i < max; i++) {
        this[i] = value[i];
      }
    }
  }
}

class Vec1 extends Object with _VecMixin implements Vec {
  final int count = 1;

  final values = List<double>(1);

  double get x => values[0];

  double operator [](int index) => values[index];

  void operator []=(int index, double value) => values[index] = value;

  Vec1({double x = 0.0}) {
    values[0] = x;
  }

  Vec1.init([double x = 0.0]) {
    values[0] = x;
  }
}

class Vec2 extends Object with _VecMixin implements Vec {
  final int count = 2;

  final values = List<double>(2);

  double get x => values[0];

  double get y => values[1];

  double operator [](int index) => values[index];

  void operator []=(int index, double value) => values[index] = value;

  Vec2({double x = 0.0, double y = 0.0}) {
    values[0] = x;
    values[1] = y;
  }

  Vec2.init([double x = 0.0, double y = 0.0]) {
    values[0] = x;
    values[1] = y;
  }
}

class Vec3 extends Object with _VecMixin implements Vec {
  final int count = 3;

  final values = List<double>(3);

  double get x => values[0];

  double get y => values[1];

  double get z => values[2];

  double operator [](int index) => values[index];

  void operator []=(int index, double value) => values[index] = value;

  Vec3({double x = 0.0, double y = 0.0, double z = 0.0}) {
    values[0] = x;
    values[1] = y;
    values[2] = z;
  }
}

class Vec4 extends Object with _VecMixin implements Vec {
  final int count = 4;

  final values = List<double>(4);

  double get x => values[0];

  double get y => values[1];

  double get z => values[2];

  double get w => values[3];

  double operator [](int index) => values[index];

  void operator []=(int index, double value) => values[index] = value;

  Vec4({double x = 0.0, double y = 0.0, double z = 0.0, double w = 1.0}) {
    values[0] = x;
    values[1] = y;
    values[2] = z;
    values[3] = w;
  }

  factory Vec4.v(double x, [double y = 0.0, double z = 0.0, double w = 0.0]) =>
      Vec4(x: x, y: y, z: z, w: w);
}

class Mat4 implements Vec {
  Mat4._() {}

  factory Mat4([Vec4 r0, Vec4 r1, Vec4 r2, Vec4 r3]) {
    final ret = Mat4._();

    if (r0 != null) ret.row0 = r0;
    if (r1 != null) ret.row1 = r1;
    if (r2 != null) ret.row2 = r2;
    if (r3 != null) ret.row3 = r3;

    return ret;
  }

  factory Mat4.fromMatrix(Matrix4 other) => Mat4._()..assign(other);

  factory Mat4.cells(
      {double cell00 = 0.0,
      double cell01 = 0.0,
      double cell02 = 0.0,
      double cell03 = 0.0,
      double cell10 = 0.0,
      double cell11 = 0.0,
      double cell12 = 0.0,
      double cell13 = 0.0,
      double cell20 = 0.0,
      double cell21 = 0.0,
      double cell22 = 0.0,
      double cell23 = 0.0,
      double cell30 = 0.0,
      double cell31 = 0.0,
      double cell32 = 0.0,
      double cell33 = 0.0}) {
    final ret = Mat4._();

    ret.set(0, 0, cell00);
    ret.set(0, 1, cell01);
    ret.set(0, 2, cell02);
    ret.set(0, 3, cell03);
    ret.set(1, 0, cell10);
    ret.set(1, 1, cell11);
    ret.set(1, 2, cell12);
    ret.set(1, 3, cell13);
    ret.set(2, 0, cell20);
    ret.set(2, 1, cell21);
    ret.set(2, 2, cell22);
    ret.set(2, 3, cell23);
    ret.set(3, 0, cell30);
    ret.set(3, 1, cell31);
    ret.set(3, 2, cell32);
    ret.set(3, 3, cell33);

    return ret;
  }

  factory Mat4.identity() => Mat4(Vec4(x: 1.0, w: 0.0), Vec4(y: 1.0, w: 0.0),
      Vec4(z: 1.0, w: 0.0), Vec4(w: 1.0));

  @override
  void operator []=(int index, double value) => values[index] = value;

  @override
  double operator [](int index) => values[index];

  double get(int row, int col) => values[(row * 4) + col];
  void set(int row, int col, double value) => values[(row * 4) + col] = value;

  @override
  final Float32List values = Float32List(16);

  @override
  int get count => 4 * 4;

  set row0(Vec4 value) {
    values[0] = value[0];
    values[1] = value[1];
    values[2] = value[2];
    values[3] = value[3];
  }

  set row1(Vec4 value) {
    values[4] = value[0];
    values[5] = value[1];
    values[6] = value[2];
    values[7] = value[3];
  }

  set row2(Vec4 value) {
    values[8] = value[0];
    values[9] = value[1];
    values[10] = value[2];
    values[11] = value[3];
  }

  set row3(Vec4 value) {
    values[12] = value[0];
    values[13] = value[1];
    values[14] = value[2];
    values[15] = value[3];
  }

  double get cell00 => values[0];
  set cell00(double value) => values[0] = value;

  double get cell01 => values[1];
  set cell01(double value) => values[1] = value;

  double get cell02 => values[2];
  set cell02(double value) => values[2] = value;

  double get cell03 => values[3];
  set cell03(double value) => values[3] = value;

  double get cell10 => values[4];
  set cell10(double value) => values[4] = value;

  double get cell11 => values[5];
  set cell11(double value) => values[5] = value;

  double get cell12 => values[6];
  set cell12(double value) => values[6] = value;

  double get cell13 => values[7];
  set cell13(double value) => values[7] = value;

  double get cell20 => values[8];
  set cell20(double value) => values[8] = value;

  double get cell21 => values[9];
  set cell21(double value) => values[9] = value;

  double get cell22 => values[10];
  set cell22(double value) => values[10] = value;

  double get cell23 => values[11];
  set cell23(double value) => values[11] = value;

  double get cell30 => values[12];
  set cell30(double value) => values[12] = value;

  double get cell31 => values[13];
  set cell31(double value) => values[13] = value;

  double get cell32 => values[14];
  set cell32(double value) => values[14] = value;

  double get cell33 => values[15];
  set cell33(double value) => values[15] = value;

  void assign(value) {
    if (value is Matrix4) {
      for (int i = 0; i < 16; i++) {
        values[i] = value[i];
      }
    } else if (value is Mat4) {
      for (int i = 0; i < 16; i++) {
        values[i] = value[i];
      }
    }
  }

  void translate(
      {double x = 0.0, double y = 0.0, double z = 0.0, double w = 1.0}) {
    values[3] = (cell00 * x) + (cell01 * y) + (cell02 * z) + (cell03 * w);
    values[7] = (cell10 * x) + (cell11 * y) + (cell12 * z) + (cell13 * w);
    values[11] = (cell20 * x) + (cell21 * y) + (cell22 * z) + (cell23 * w);
    values[15] = (cell30 * x) + (cell31 * y) + (cell32 * z) + (cell33 * w);
  }

  void rotateZ(double radians) {
    final cosTheta = math.cos(radians);
    final sinTheta = math.sin(radians);

    cell00 = cell00 * cosTheta + cell01 * sinTheta;
    cell01 = cell00 * -sinTheta + cell01 * cosTheta;

    cell10 = cell10 * cosTheta + cell11 * sinTheta;
    cell11 = cell10 * -sinTheta + cell11 * cosTheta;

    cell20 = cell20 * cosTheta + cell21 * sinTheta;
    cell21 = cell20 * -sinTheta + cell21 * cosTheta;

    cell30 = cell30 * cosTheta + cell31 * sinTheta;
    cell31 = cell30 * -sinTheta + cell31 * cosTheta;
  }

  String toString() => values.toString();

  static Mat4 ortho(double left, double right, double bottom, double top,
      double near, double far) {
    final double rml = right - left;
    final double rpl = right + left;
    final double tmb = top - bottom;
    final double tpb = top + bottom;
    final double fmn = far - near;
    final double fpn = far + near;

    return Mat4.cells(
      cell00: 2 / rml,
      cell11: 2 / tmb,
      cell22: -2 / fmn,
      cell33: 1.0,
      cell03: -rpl / rml,
      cell13: -tpb / tmb,
      cell23: -fpn / fmn,
    );
  }
}
