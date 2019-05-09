import 'dart:io';
import 'package:slp_reader/palette.dart';
import 'package:slp_reader/slp_reader.dart';
import 'package:slp_to_spr/slp_to_spr.dart';

import 'package:slp_to_spr/cmd.dart';

import 'package:path/path.dart' as path;

main(List<String> arguments) async {
  final options = Options.parse(arguments);

  // String paletteFile = "test_data/AOE2_Beta.pal";
  // String slpFile = "test_data/barrack.slp";
  // String outputDir = "test_data/barrack";

  await convert(options);
}

Future<void> convert(Options options) async {
  // Parse palette
  List<Color> palette;
  if (options.palette != null) {
    palette = parse(await File(options.palette).readAsBytes());
  } else {
    palette = parse(defaultPalette.codeUnits);
  }

  // Read SLP file
  final frames = await readSlp(palette, await File(options.slp).readAsBytes());

  if (options.angles.isNotEmpty) {
    if (frames.length % options.angles.length != 0) {
      throw "Angles and number of frames in the SLP do not match!";
    }
  }

  // Write output
  await Directory(options.out).create(recursive: true);

  if (options.angles.isNotEmpty) {
    final int per = frames.length ~/ options.angles.length;
    int i = 0;
    for (String angle in options.angles) {
      final anglepath = path.join(options.out, angle);
      await Directory(anglepath).create(recursive: true);
      await write(Directory(anglepath), frames.skip(i * per).take(per));
      i++;
    }
  } else {
    await write(Directory(options.out), frames);
  }
}

Future<void> write(Directory dir, Iterable<Frame> frames) async {
  final spr = convertToYaml(frames);
  await File(path.join(dir.path, 'sprite.yaml')).writeAsString(spr);
  for (int i = 0; i < frames.length; i++) {
    await File(path.join(dir.path, "${i + 1}.png"))
        .writeAsBytes(frames.elementAt(i).makeImagePng);
  }
}
