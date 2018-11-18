import 'package:meta/meta.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:slp_reader/palette.dart';

class Buffer {
  Iterable<int> _src;

  Iterable<int> _data;

  Buffer(this._src) {
    _data = _src.skip(0);
  }

  void rewind() => _data = _src.skip(0);

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

class RowPadding {
  final int rowWidth;
  final int leftPadding;
  final int rightPadding;

  RowPadding({this.leftPadding, this.rightPadding, this.rowWidth});

  int get width => rowWidth - leftPadding - rightPadding;

  String toString() => "OutlineRow($leftPadding, $rightPadding)";

  static RowPadding parse(Buffer buffer, int width) {
    int left = buffer.uint16;
    int right = buffer.uint16;
    return RowPadding(leftPadding: left, rightPadding: right, rowWidth: width);
  }

  static List<RowPadding> parseAllRows(Buffer buffer, int height, int width) {
    final ret = List<RowPadding>(height);
    for (int i = 0; i < height; i++) {
      ret[i] = parse(buffer, width);
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

  final List<RowPadding> rowPaddings;

  final List<List<Color>> image;

  Frame(this.info, this.rowPaddings, this.image);

  img.Image get makeMask {
    final maskImage = img.Image(info.width, info.height);
    for (int h = 0; h < info.height; h++) {
      final row = rowPaddings[h];
      for (int c = row.leftPadding; c < info.width - row.rightPadding; c++) {
        maskImage.setPixel(c, h, 0xffffffff);
      }
    }
    return maskImage;
  }

  img.Image get makeImage {
    final maskImage = img.Image(info.width, info.height);
    for (int r = 0; r < info.height; r++) {
      for (int c = 0; c < info.width; c++) {
        maskImage.setPixel(c, r, image[r][c].rgba);
      }
    }
    return maskImage;
  }

  String toString() => "Frame()";

  static Frame parse(Buffer buffer, FrameInfo info, List<Color> palette) {
    buffer.skip(info.outlineTableOffset);

    List<RowPadding> outlineRows =
        RowPadding.parseAllRows(buffer, info.height, info.width);

    buffer.rewind();
    buffer.skip(info.cmdTableOffset);

    List<int> lineOffsets = buffer.uint32List(info.height);

    final image = List<List<Color>>.generate(
        info.height, (i) => List<Color>.filled(info.width, Color.transparent));

    for (int i = 0; i < info.height; i++) {
      final row = image[i];
      buffer.rewind();
      buffer.skip(lineOffsets[i]);
      final lines = parseLine(buffer, 1, palette);
      _replaceRange(row, outlineRows[i].leftPadding, lines);
    }

    return Frame(info, outlineRows, image);
  }
}

void _replaceRange<T>(List<T> dst, int index, Iterable<T> n) {
  for (int i = index; i < i + n.length; i++) {
    dst[i] = n.first;
    n = n.skip(1);
  }
}

List<Color> parseLine(Buffer buffer, int player, List<Color> palette) {
  final ret = <Color>[];
  int playerPaletteIndex = player * 16;
  bool finished = false;
  do {
    int firstByte = buffer.byte;
    int command = firstByte & 0xF;
    switch (command) {
      // Lesser block copy
      case 0x0:
      case 0x4:
      case 0x8:
      case 0xc:
        final int length = firstByte >> 2;
        final colors = buffer.bytes(length).map((i) => palette[i]);
        ret.addAll(colors);
        break;
      // Greater block copy
      case 0x2:
        final int length = ((firstByte & 0xF0) << 0x4) | buffer.byte;
        final colors = buffer.bytes(length).map((i) => palette[i]);
        ret.addAll(colors);
        break;
      // Lesser skip
      case 0x1:
      case 0x5:
      case 0x9:
      case 0xd:
        final int length = firstByte >> 2;
        final colors = List<Color>.filled(length, Color.transparent);
        ret.addAll(colors);
        break;
      // Greater skip
      case 0x3:
        final int length = ((firstByte & 0xF0) << 0x4) | buffer.byte;
        final colors = List<Color>.filled(length, Color.transparent);
        ret.addAll(colors);
        break;
      // Player color block copy
      case 0x6:
        int length = firstByte >> 4;
        if (length == 0) {
          length = buffer.byte;
        }
        final colors =
            buffer.bytes(length).map((i) => palette[playerPaletteIndex + i]);
        ret.addAll(colors);
        break;
      // Fill
      case 0x7:
        int length = firstByte >> 4;
        if (length == 0) {
          length = buffer.byte;
        }
        final int index = buffer.byte;
        final colors = List<Color>.filled(length, palette[index]);
        ret.addAll(colors);
        break;
      case 0xa:
        int length = firstByte >> 4;
        if (length == 0) {
          length = buffer.byte;
        }
        final int index = buffer.byte;
        final colors =
            List<Color>.filled(length, palette[playerPaletteIndex + index]);
        ret.addAll(colors);
        break;
      case 0xb:
        throw Exception("Shadow command not implemented!");
        // TODO
        break;
      case 0xe:
        throw Exception("Extended command not implemented!");
        // TODO
        break;
      // Command end
      case 0xf:
        finished = true;
        break;
      default:
        throw Exception("Unknown command!");
    }
  } while (!finished);
  return ret;
}
