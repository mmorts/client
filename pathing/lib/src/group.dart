import 'dart:math';
import 'geom.dart';

// TODO Convert to double?
Position centroid(Iterable<Position> points) {
  final ret = Position();
  for (Position p in points) {
    ret.x += p.x;
    ret.y += p.y;
  }
  int numPoints = points.length;
  ret.x = ret.x ~/ numPoints;
  ret.y = ret.y ~/ numPoints;
  return ret;
}

void incrementalCentroid(Position centroid, Position newPos, int length) {
  int nMinus1 = length - 1;
  centroid.x = ((centroid.x / nMinus1) + newPos.x) ~/ length;
  centroid.y = ((centroid.y / nMinus1) + newPos.y) ~/ length;
}

class Group {
  final double distance;

  final centroid = Position();

  final members = List<HasPosition>();

  Rectangle<double> _boundingBox;

  Group(this.distance);

  bool contains(Position point) =>
      _boundingBox.containsPoint(Point<int>(point.x, point.y));

  void addMember(HasPosition member) {
    members.add(member);
    incrementalCentroid(centroid, member.pos, members.length);
    _boundingBox = Rectangle<double>(centroid.x - distance,
        centroid.y - distance, distance * 2, distance * 2);
  }
}

List<Group> group(List<HasPosition> units, double distance) {
  final groups = <Group>[];

  for (final unit in units) {
    if (groups.isEmpty) {
      groups.add(Group(distance)..addMember(unit));
      continue;
    }

    Group inGroup;
    for (Group group in groups) {
      if(!group.contains(unit.pos)) continue;
      group.addMember(unit);
      inGroup = group;
      break;
    }

    if(inGroup == null) {
      groups.add(Group(distance)..addMember(unit));
    }
  }

  return groups;
}
