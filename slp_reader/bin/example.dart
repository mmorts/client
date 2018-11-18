import 'dart:async';
import 'dart:io';
import 'package:slp_reader/slp_reader.dart';
import 'package:slp_reader/palette.dart';

import 'package:image/image.dart' as img;

main() async {
  final bytes = await File("bin/data/130.slp").readAsBytes();
  var buffer = Buffer(bytes);
  final header = Header.parse(buffer);

  print(header);

  final frameInfo = FrameInfo.parse(buffer);
  print(frameInfo);

  final paletteFile = await File("bin/data/AOE2_Beta.pal").readAsBytes();
  final palette = parse(paletteFile);

  buffer.rewind();
  final frame = Frame.parse(buffer, frameInfo, palette);
  print(frame.rowPaddings);

  await File("bin/data/mask.png").writeAsBytes(img.encodePng(frame.makeMask));
  await File("bin/data/image.png").writeAsBytes(img.encodePng(frame.makeImage));
}
