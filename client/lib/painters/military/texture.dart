part of 'military.dart';

class MilitaryDirTextures {
  final Iterable<Texture> s;
  final Iterable<Texture> sw;
  final Iterable<Texture> w;
  final Iterable<Texture> nw;
  final Iterable<Texture> n;

  MilitaryDirTextures({this.s, this.sw, this.w, this.nw, this.n});

  Iterable<Texture> byDir(UnitDirection dir) {
    switch (dir) {
      case UnitDirection.s:
        return s;
      case UnitDirection.sw:
      case UnitDirection.se:
        return sw;
      case UnitDirection.w:
      case UnitDirection.e:
        return w;
      case UnitDirection.nw:
      case UnitDirection.ne:
        return nw;
      case UnitDirection.n:
        return n;
      default:
        return s;
    }
  }

  static Future<MilitaryDirTextures> load(
      RenderingContext2 gl, String path) async {
    List<Texture> w = await loadOneDir(gl, path + "/w");
    List<Texture> s = await loadOneDir(gl, path + "/s");
    List<Texture> n = await loadOneDir(gl, path + "/n");
    List<Texture> nw = await loadOneDir(gl, path + "/nw");
    List<Texture> sw = await loadOneDir(gl, path + "/sw");

    return MilitaryDirTextures(
      w: w,
      s: s,
      n: n,
      nw: nw,
      sw: sw,
    );
  }

  static Future<List<Texture>> loadOneDir(
      RenderingContext2 gl, String path) async {
    final ret = <Texture>[];

    resty.StringResponse resp;
    int frameCount = 1;
    do {
      resp = await resty.get(path + "/$frameCount.png").go();
      if (resp.statusCode != 404) {
        ret.add(texFromBytes(resp.bytes, gl: gl).texture);
      }
      frameCount++;
    } while (resp.statusCode != 404);

    if (ret.isEmpty) throw Exception("No frames found!");

    return ret;
  }
}

class MilitaryTextures {
  final MilitaryDirTextures stand;

  final MilitaryDirTextures walk;

  final MilitaryDirTextures attack;

  final MilitaryDirTextures die;

  final MilitaryDirTextures rot;

  MilitaryTextures({this.stand, this.walk, this.attack, this.die, this.rot});

  Iterable<Texture> by({UnitVerb state, UnitDirection dir}) {
    switch (state) {
      case UnitVerb.stand:
        return stand.byDir(dir);
      case UnitVerb.walk:
        return walk.byDir(dir);
      case UnitVerb.attack:
        return attack.byDir(dir);
      case UnitVerb.die:
        return die.byDir(dir);
      case UnitVerb.rot:
        return rot.byDir(dir);
      default:
        return stand.byDir(dir);
    }
  }

  static Future<MilitaryTextures> load(
      RenderingContext2 gl, String path) async {
    final stand = await MilitaryDirTextures.load(gl, path + "/stand");
    // final walk = await MilitaryDirTextures.load(gl, path + "/walk");
    return MilitaryTextures(
      stand: stand, /* walk: walk */
    );
  }
}
