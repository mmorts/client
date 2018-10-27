part of 'ezwebgl.dart';

abstract class GlData {
  List<Vec> get asGlData;
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

class DataArray<V extends GlData> {
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
      for(int j = 0; j < stride; j++) {
        if(dataIndex == data.length) {
          data = vecs[vecIndex++].values;
          dataIndex = 0;
        }
        ret[rowStart + j] = data[dataIndex++];
      }
    }

    return ret;
  }

  void add(GlData data) {
    elements.add(data);
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

  Vec4({double x = 0.0, double y = 0.0, double z = 0.0, double w = 0.0}) {
    values[0] = x;
    values[1] = y;
    values[2] = z;
    values[3] = w;
  }
}
