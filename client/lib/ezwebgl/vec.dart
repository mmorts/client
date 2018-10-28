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

class Vec1 implements Vec {
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

class Vec2 implements Vec {
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

class Vec3 implements Vec {
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

class Vec4 implements Vec {
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
}
