import 'dart:async';
import 'dart:io';
import 'package:slp_reader/slp_reader.dart';
import 'package:slp_reader/palette.dart';

import 'package:image/image.dart' as img;

import 'package:slp_reader/buffer.dart';

main() async {
  final paletteFile = await File("bin/data/AOE2_Beta.pal").readAsBytes();
  final palette = parse(paletteFile);

  /*
  {
    List<Frame> frames = await readSlp(palette, File("bin/data/130.slp"));

    for (int i = 0; i < frames.length; i++) {
      final frame = frames[i];

      await Directory("bin/data/130").createSync(recursive: true);
      await File("bin/data/130/mask_$i.png")
          .writeAsBytes(img.encodePng(frame.makeMask));
      await File("bin/data/130/image_$i.png")
          .writeAsBytes(img.encodePng(frame.makeImage));
    }
  }
  */

  {
    String base = "bin/data/corpse";
    List<Frame> frames = await readSlp(palette, File("$base.slp"));

    for (int i = 0; i < frames.length; i++) {
      final frame = frames[i];

      await Directory(base).createSync(recursive: true);
      await File("$base/mask_$i.png")
          .writeAsBytes(img.encodePng(frame.makeMask));
      await File("$base/image_$i.png")
          .writeAsBytes(img.encodePng(frame.makeImage));
    }
  }

  /*

  {
    List<Frame> frames = await readSlp(palette, File("bin/data/100.slp"));

    for (int i = 0; i < frames.length; i++) {
      final frame = frames[i];

      await Directory("bin/data/100").createSync(recursive: true);
      await File("bin/data/100/mask_$i.png")
          .writeAsBytes(img.encodePng(frame.makeMask));
      await File("bin/data/100/image_$i.png")
          .writeAsBytes(img.encodePng(frame.makeImage));
    }
  }
  */
}

Future<List<Frame>> readSlp(List<Color> palette, File src) async {
  final bytes = await src.readAsBytes();
  var buffer = Buffer(bytes);
  final header = Header.parse(buffer);

  print(header);

  final frames = List<Frame>(header.numFrames);

  for (int i = 0; i < header.numFrames; i++) {
    final frame = Frame.parse(buffer, i, palette);
    frames[i] = frame;
  }

  return frames;
}
