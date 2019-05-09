part of 'military.dart';

class MilitaryDirTextures {
  final Sprite s;
  final Sprite sw;
  final Sprite w;
  final Sprite nw;
  final Sprite n;

  MilitaryDirTextures({this.s, this.sw, this.w, this.nw, this.n});

  Sprite byDir(UnitDirection dir) {
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
    Sprite w = await loadOneDir(gl, path + "/w");
    Sprite s = await loadOneDir(gl, path + "/s");
    Sprite n = await loadOneDir(gl, path + "/n");
    Sprite nw = await loadOneDir(gl, path + "/nw");
    Sprite sw = await loadOneDir(gl, path + "/sw");

    return MilitaryDirTextures(
      w: w,
      s: s,
      n: n,
      nw: nw,
      sw: sw,
    );
  }

  static Future<Sprite> loadOneDir(RenderingContext2 gl, String path) async {
    final ret = <Frame>[];

    resty.StringResponse resp = await resty.get(path + "/sprite.yaml").go();
    if (resp.statusCode != 200) throw resp;
    final spriteSpec = spec.Sprite.decode(yaml.loadYaml(resp.body));

    int frameCount = spriteSpec.numFrames;

    for (int i = 1; i <= frameCount; i++) {
      resp = await resty.get(path + "/$i.png").go();
      if (resp.statusCode != 200) throw resp;
      final sizedTex = texFromBytes(resp.bytes, gl: gl);
      ret.add(Frame(
          size: sizedTex.size,
          texture: sizedTex.texture,
          hotspot: Point<double>(spriteSpec.frames[i - 1].hotspot.x.toDouble(),
              spriteSpec.frames[i - 1].hotspot.y.toDouble())));
    }

    if (ret.isEmpty) throw Exception("No frames found!");

    return Sprite(ret);
  }
}

class MilitaryTextures {
  final MilitaryDirTextures stand;

  final MilitaryDirTextures walk;

  final MilitaryDirTextures attack;

  final MilitaryDirTextures die;

  final MilitaryDirTextures rot;

  MilitaryTextures({this.stand, this.walk, this.attack, this.die, this.rot});

  Sprite by({UnitVerb state, UnitDirection dir}) {
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
