import 'dart:typed_data';

import 'buffer.dart';

class Blendomatic {
  int numBlendingModes;
  int numTiles;
}

parse(List<int> bytes) {
  final buffer = Buffer(bytes);
  final numBlendingModes = buffer.uint32;
  final numTiles = buffer.uint32;

  print(numBlendingModes);
  print(numTiles);

  parseMode(buffer, 0, numTiles);
}

parseMode(Buffer buffer, int modeNum, int numTiles) {
  int modeSpace = 0;  // TODO
  buffer.rewind(8 + (modeNum * modeSpace));

  int tileSize = buffer.uint32;
  List<int> tileFlags = buffer.bytes(numTiles);

  print(tileSize);
  print(tileFlags);

  /*
  		struct {
			uint8_t alpha_bitmask[tile_size / 8];    // with tile_size pixels, use the data bitwise.
		} tile_bitmasks[32];                         // why 32? maybe nr_tiles + 1?

		struct {
			uint8_t alpha_bytemap[tile_size];        // 7-bit alpha value pixels
		} tile_bytemasks[nr_tiles];
   */
}