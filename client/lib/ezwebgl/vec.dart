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
  final row0 = Vec4();
  final row1 = Vec4();
  final row2 = Vec4();
  final row3 = Vec4();

  final List<Vec4> rows;

  Mat4._() : rows = List<Vec4>(4) {
    rows[0] = row0;
    rows[1] = row1;
    rows[2] = row2;
    rows[3] = row3;
  }

  factory Mat4([Vec4 r0, Vec4 r1, Vec4 r2, Vec4 r3]) {
    final ret = Mat4._();

    ret.row0.assign(r0);
    ret.row1.assign(r1);
    ret.row2.assign(r2);
    ret.row3.assign(r3);

    return ret;
  }

  factory Mat4.fromMatrix(Matrix4 other) => Mat4._()..assign(other);

  factory Mat4.cells(
      {double e00 = 0.0,
      double e01 = 0.0,
      double e02 = 0.0,
      double e03 = 0.0,
      double e10 = 0.0,
      double e11 = 0.0,
      double e12 = 0.0,
      double e13 = 0.0,
      double e20 = 0.0,
      double e21 = 0.0,
      double e22 = 0.0,
      double e23 = 0.0,
      double e30 = 0.0,
      double e31 = 0.0,
      double e32 = 0.0,
      double e33 = 0.0}) {
    final ret = Mat4._();

    ret.set(0, 0, e00);
    ret.set(0, 1, e01);
    ret.set(0, 2, e02);
    ret.set(0, 3, e03);
    ret.set(1, 0, e10);
    ret.set(1, 1, e11);
    ret.set(1, 2, e12);
    ret.set(1, 3, e13);
    ret.set(2, 0, e20);
    ret.set(2, 1, e21);
    ret.set(2, 2, e22);
    ret.set(2, 3, e23);
    ret.set(3, 0, e30);
    ret.set(3, 1, e31);
    ret.set(3, 2, e32);
    ret.set(3, 3, e33);

    return ret;
  }

  factory Mat4.identity() => Mat4(Vec4(x: 1.0, w: 0.0), Vec4(y: 1.0, w: 0.0),
      Vec4(z: 1.0, w: 0.0), Vec4(w: 1.0));

  @override
  void operator []=(int index, double value) {
    rows[index ~/ 4][index % 4] = value;
  }

  @override
  double operator [](int index) => rows[index ~/ 4][index % 4];

  double get(int x, int y) => rows[x][y];
  void set(int x, int y, double value) => rows[x][y] = value;

  @override
  Float32List get values => Float32List.fromList([
        row0.x,
        row0.y,
        row0.z,
        row0.w,
        row1.x,
        row1.y,
        row1.z,
        row1.w,
        row2.x,
        row2.y,
        row2.z,
        row2.w,
        row3.x,
        row3.y,
        row3.z,
        row3.w,
      ]);

  @override
  int get count => 4 * 4;

  void assign(value) {
    if (value is Matrix4) {
      for (int i = 0; i < 4; i++) {
        rows[i].assign(value.getRow(i));
      }
    }
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
      e00: 2 / rml,
      e11: 2 / tmb,
      e22: -2 / fmn,
      e33: 1.0,
      e03: -rpl / rml,
      e13: -tpb / tmb,
      e23: -fpn / fmn,
    );
  }
}
