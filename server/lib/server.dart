import 'ability.dart';
import 'package:meta/meta.dart';

class Tile {
  /// Is the tile water or land
  final bool isWater;

  final Position position;

  /// Objects contained in the tile
  final List<GameObject> objects;

  Tile(
      {this.isWater: false,
      @required this.position,
      @required this.objects});

  /// Elevation of the tile
  double get elevation => position.z;
}

/// A object in the game that has a visual representation
class GameObject {
  int player;

  Position pos;

  // TODO bounding box

  GameObject({this.player, this.pos});
}

/// A three dimensional position in the game
class Position {
  double x;

  double y;

  double z;
}

class Game {
  final List<Tile> tiles;

  final Map<String, GameObject> objects;

  final List<Player> players;

  final List<Team> teams;

  Game(
      {@required this.tiles,
      @required this.objects,
      @required this.players,
      @required this.teams});
}

class Player {
  final int id;

  final Map<String, GameObject> objects;

  Player({@required this.id, @required this.objects});
}

class Team {
  final int id;

  final List<Player> players;

  Team({@required this.id, @required this.players});
}
