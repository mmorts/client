import 'dart:convert';
import 'package:image/image.dart' as img;

class Color {
  final int r;

  final int g;

  final int b;

  final int a;

  const Color({this.r = 0, this.g = 0, this.b = 0, this.a = 255});

  const Color.v(this.r, [this.g = 0, this.b = 0, this.a = 255]);

  factory Color.fromArray(Iterable<int> v) => Color.v(v.elementAt(0),
      v.elementAt(1), v.elementAt(2), v.length > 3 ? v.elementAt(3) : 255);

  String toString() => "Color($r, $g, $b, $a)";

  int get rgba => img.getColor(r, g, b, a);

  static Color fromArrayText(String value) {
    List<int> parts = value.split(' ').map((v) => int.tryParse(v)).toList();
    if (parts.length != 3 || parts.contains(null)) {
      throw Exception("Invalid color format");
    }
    return Color.fromArray(parts);
  }

  static const transparent = Color(a: 0);
}

List<Color> parse(List<int> bytes) {
  img.Color;
  final lines = LineSplitter().convert(String.fromCharCodes(bytes));

  if (lines.length < 3) throw Exception("Invalid format: No header!");

  if (lines.first != "JASC-PAL")
    throw Exception("Invalid format: Wrong header!");

  if (lines[1] != "0100") throw Exception("Invalid version!");

  final numColors = int.tryParse(lines[2]);

  if (lines.length < (numColors + 3)) throw Exception("Not enough colors!");

  return lines.skip(3).map(Color.fromArrayText).toList();
}
