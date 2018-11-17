import 'dart:async';
import 'dart:io';
import 'package:slp_reader/slp_reader.dart';

import 'package:image/image.dart' as img;

main() async {
  final bytes = await File("bin/data/130.slp").readAsBytes();
  var buffer = Buffer(bytes);
  final header = Header.parse(buffer);

  print(header);

  final frameInfo = FrameInfo.parse(buffer);
  print(frameInfo);

  buffer = Buffer(bytes);
  final frame = Frame.parse(buffer, frameInfo);
  print(frame.outlineRows);

  final image = img.Image(frameInfo.width, frameInfo.height);

  for(int h = 0; h < frameInfo.height; h++) {
    final row = frame.outlineRows[h];
    for(int c = row.left; c < frame.info.width - row.right; c++) {
      image.setPixel(c, h, 0xffffffff);
    }
  }

  final file = img.PngEncoder().encodeImage(image);
  await File("outline.png").writeAsBytes(file);
}