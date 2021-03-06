import 'package:meta/meta.dart';

/// A three dimensional position in the game
class Position {
  double x;

  double y;
}

class Tile {
  /// Is the tile water or land
  final bool isWater;

  final Position position;

  /// Objects contained in the tile
  final List<dynamic> objects;

  Tile(
      {this.isWater: false,
        @required this.position,
        @required this.objects});
}