import 'dart:io';
import 'package:slp_reader/blendomatic_reader.dart';

main() async {
  final bytes = await File("bin/data/blendomatic_x1.dat").readAsBytes();
  parse(bytes);
}