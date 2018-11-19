import 'dart:io';
import 'package:slp_reader/palette.dart';
import 'package:slp_reader/slp_reader.dart';
import 'package:slp_to_spr/slp_to_spr.dart';

main(List<String> arguments) async {
  String paletteFile = "test_data/AOE2_Beta.pal";
  String slpFile = "test_data/barrack.slp";

  String outputDir = "test_data/barrack";

  // read
  final palette = parse(await File(paletteFile).readAsBytes());
  final frames = await readSlp(palette, await File(slpFile).readAsBytes());

  // Convert
  final spr = convertToYaml(frames);

  // Write
  await Directory(outputDir).create(recursive: true);
  await File("$outputDir/spr.yaml").writeAsString(spr);
  for (int i = 0; i < frames.length; i++) {
    await File("$outputDir/${i + 1}.png").writeAsBytes(frames[i].makeImagePng);
  }
}
