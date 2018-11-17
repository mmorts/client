import 'package:meta/meta.dart';
import 'dart:typed_data';

class Buffer {
  Iterable<int> _data;

  Buffer(this._data);

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

  int get uint32 => next(4).buffer.asByteData().getUint32(0, Endian.little);

  int get uint16 => next(2).buffer.asByteData().getUint16(0, Endian.little);
}

class Header {
  String version;

  int numFrames;

  String comment;

  Header({this.version, this.numFrames, this.comment});

  String toString() => "Header($version, $numFrames, $comment)";

  static Header parse(Buffer bytes) {
    final String version = bytesToString(bytes.next(4));
    final int numFrames = bytes.uint32;
    final String comment = bytesToString(bytes.next(24));
    return Header(version: version, numFrames: numFrames, comment: comment);
  }
}

class FrameInfo {
  int cmdTableOffset;

  int outlineTableOffset;

  int paletteOffset;

  int props;

  int width;

  int height;

  int hotspotX;

  int hotspotY;

  FrameInfo(
      {@required this.cmdTableOffset,
      @required this.outlineTableOffset,
      @required this.paletteOffset,
      @required this.props,
      @required this.width,
      @required this.height,
      @required this.hotspotX,
      @required this.hotspotY});

  String toString() => "FrameInfo(cmdTableOffset: $cmdTableOffset, "
      "outlineTableOffset: $outlineTableOffset, "
      "paletteOffset: $paletteOffset, "
      "props: $props, "
      "width: $width, "
      "height: $height, "
      "hotspotX: $hotspotX, "
      "hotspotY: $hotspotY)";

  static FrameInfo parse(Buffer buffer) {
    int cmdTableOffset = buffer.uint32;
    int outlineTableOffset = buffer.uint32;
    int paletteOffset = buffer.uint32;
    int props = buffer.uint32;
    int width = buffer.uint32;
    int height = buffer.uint32;
    int hotspotX = buffer.uint32;
    int hotspotY = buffer.uint32;
    return FrameInfo(
        cmdTableOffset: cmdTableOffset,
        outlineTableOffset: outlineTableOffset,
        paletteOffset: paletteOffset,
        props: props,
        width: width,
        height: height,
        hotspotX: hotspotX,
        hotspotY: hotspotY);
  }
}

class OutlineRowInfo {
  int left;
  int right;

  OutlineRowInfo({this.left, this.right});

  String toString() => "OutlineRow($left, $right)";

  static OutlineRowInfo parse(Buffer buffer) {
    int left = buffer.uint16;
    int right = buffer.uint16;
    return OutlineRowInfo(left: left, right: right);
  }

  static List<OutlineRowInfo> parseAllRows(Buffer buffer, int height) {
    final ret = List<OutlineRowInfo>(height);
    for (int i = 0; i < height; i++) {
      ret[i] = parse(buffer);
    }
    return ret;
  }
}

abstract class Cmd {
  static const colorList = 0;
  static const skip = 1;
  static const bigColorList = 2;
  static const bigSkip = 3;
  static const playerColorList = 0x6;
  static const fill = 0x7;
  static const playerColorFill = 0xa;
  static const shadowTransparent = 0xb;
  static const shadowPlayer = 0xe;
  static const endOfRow = 0xf;
  static const outline = 0x4e;
  static const outlineSpan = 0x5e;
}

String bytesToString(Iterable<int> bytes) {
  int last = bytes.length;
  for (int i = 0; i < bytes.length; i++) {
    if (bytes.elementAt(i) == 0) {
      last = i;
      break;
    }
  }

  return String.fromCharCodes(bytes.take(last));
}

class Frame {
  final FrameInfo info;

  final List<OutlineRowInfo> outlineRows;

  Frame(this.info, this.outlineRows);

  String toString() => "Frame()";

  static Frame parse(Buffer buffer, FrameInfo info) {
    buffer.skip(info.outlineTableOffset);

    List<OutlineRowInfo> outlineRows =
        OutlineRowInfo.parseAllRows(buffer, info.height);

    return Frame(info, outlineRows);
  }
}
