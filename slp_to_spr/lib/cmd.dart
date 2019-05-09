import 'dart:io';
import 'package:meta/meta.dart';

import 'package:args/args.dart' as args;

class Options {
  final String palette;

  final String slp;

  final String out;

  final List<String> angles;

  Options({
    @required this.palette,
    @required this.slp,
    @required this.out,
    @required this.angles,
  });

  static String usage = """
Converts AoE2 SLP files to sprite files.

Example:
slp2spr [-p palette_path] [-o output_dir] [-a angles] slp_file

""";

  static Options parse(List<String> arguments) {
    final parser = args.ArgParser();

    parser.addOption("palette",
        abbr: 'p', help: "Specifies path to palette file");
    parser.addOption("out",
        abbr: 'o', help: "Specifies path to SLP file to convert");
    parser.addMultiOption("angles",
        abbr: 'a',
        help: "Specifies angles",
        splitCommas: true,
        valueHelp: 's,sw,w,nw,n');

    parser.addFlag('help', abbr: 'h', help: 'Prints help text for this command.');

    final results = parser.parse(arguments);

    if(results['help'] != null && results['help']) {
      print(usage + parser.usage);
      exit(0);
    }

    if (results.rest.isEmpty || results.rest.length > 1) {
      throw usage + parser.usage;
    }

    final slp = results.rest.first;

    return Options(
      palette: results['palette'],
      out: results['out'],
      slp: slp,
      angles: (results['angles'] as List)?.cast<String>() ?? <String>[],
    );
  }
}
