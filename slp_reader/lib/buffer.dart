import 'dart:typed_data';

class Buffer {
  Iterable<int> _src;

  Iterable<int> _data;

  Buffer(this._src) {
    _data = _src.skip(0);
  }

  void rewind([int count = 0]) => _data = _src.skip(count);

  Buffer branch() => Buffer(_data.skip(0));

  int get pos => _src.length - _data.length;

  void skip(int count) {
    if (_data.length < count)
      throw Exception("Do not have $count elements in buffer!");
    _data = _data.skip(count);
  }

  Uint8List next(int count) {
    if (_data.length < count)
      throw Exception("Do not have $count elements in buffer!");
    final ret = Uint8List.fromList(_data.take(count).toList());
    _data = _data.skip(count);
    return ret;
  }

  int get byte {
    int ret = _data.first;
    _data = _data.skip(1);
    return ret;
  }

  int get uint32 => next(4).buffer.asByteData().getUint32(0, Endian.little);

  int get uint16 => next(2).buffer.asByteData().getUint16(0, Endian.little);

  Uint8List bytes(int length) => next(length);

  Uint32List uint32List(int length) => next(length * 4).buffer.asUint32List();

  Uint16List uint16List(int length) => next(length * 2).buffer.asUint16List();
}