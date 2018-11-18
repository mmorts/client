import 'dart:io';
import 'package:slp_reader/palette.dart';
import 'package:image/image.dart' as img;

main() async {
  final file = await File("bin/data/AOE2_Beta.pal").readAsBytes();
  final colors = parse(file);
  print(colors);

  final image = img.Image(16 * 16, 16 * 16);
  for (int i = 0; i < 16; i++) {
    for (int j = 0; j < 16; j++) {
      Color color = colors[i * 16 + j];
      final rect =
          img.Image(16, 16).fill(img.getColor(color.r, color.g, color.b));
      int top = i * 16;
      int left = j * 16;
      img.copyInto(image, rect, dstX: left, dstY: top);
    }
  }

  await File("bin/data/palette.png").writeAsBytes(img.encodePng(image));
}
