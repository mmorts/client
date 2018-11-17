import 'dart:math' as math;
import 'dart:async';
import 'dart:web_gl';
import 'dart:typed_data';
import 'package:vector_math/vector_math.dart';

import 'package:meta/meta.dart';

import 'package:jaguar_resty/jaguar_resty.dart' as resty;
import 'package:image/image.dart' as imTools;
import 'vec.dart';

export 'vec.dart';

part 'shader.dart';
part 'texture.dart';

class Uniform {
  final ShaderProgram program;

  final UniformLocation location;

  Uniform({this.program, this.location});

  void set1f(num x) {
    gl.uniform1f(location, x);
  }

  RenderingContext2 get gl => program.gl;
}

class AttributeLocation {
  final int location;

  final ShaderProgram program;

  AttributeLocation({this.location, this.program});

  RenderingContext2 get gl => program.gl;
}

abstract class BufData {
  List<Vec> get asGlData;
}

class PosBuf implements BufData {
  final Vec4 position;

  PosBuf({@required this.position});

  PosBuf.coords({double x: 0.0, double y: 0.0, double z: 0.0, double w: 1.0})
      : position = Vec4.v(x, y, z, w);

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

  PosTexBuf.coords(
      {double x: 0.0,
      double y: 0.0,
      double z: 0.0,
      double w: 1.0,
      double tx: 0.0,
      double ty: 0.0})
      : position = Vec4.v(x, y, z, w),
        texCoords = Vec2.init(tx, ty);

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
