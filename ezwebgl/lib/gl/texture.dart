part of 'gl.dart';

class SizedTexture {
  final Texture texture;

  final math.Point size;

  SizedTexture(this.texture, this.size);
}

Future<SizedTexture> texFromUrl(String url,
    {@required RenderingContext2 gl}) async {
  final resp = await resty.get(url).go();
  return texFromBytes(resp.bytes, gl: gl);
}

SizedTexture texFromBytes(List<int> bytes, {@required RenderingContext2 gl}) {
  imTools.Image image = imTools.decodePng(bytes);

  final Texture texture = gl.createTexture();
  gl.bindTexture(WebGL.TEXTURE_2D, texture);

  gl.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_MIN_FILTER, WebGL.LINEAR);
  gl.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_WRAP_S, WebGL.CLAMP_TO_EDGE);
  gl.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_WRAP_T, WebGL.CLAMP_TO_EDGE);

  gl.texImage2D2(WebGL.TEXTURE_2D, 0, WebGL.RGBA, image.width, image.height, 0,
      WebGL.RGBA, WebGL.UNSIGNED_BYTE, image.getBytes(), 0);

  return SizedTexture(texture,
      math.Point<double>(image.width.toDouble(), image.height.toDouble()));
}

Texture texFromImage(imTools.Image image, {@required RenderingContext2 gl}) {
  final Texture texture = gl.createTexture();
  gl.bindTexture(WebGL.TEXTURE_2D, texture);

  gl.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_MIN_FILTER, WebGL.LINEAR);
  gl.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_WRAP_S, WebGL.CLAMP_TO_EDGE);
  gl.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_WRAP_T, WebGL.CLAMP_TO_EDGE);

  gl.texImage2D2(WebGL.TEXTURE_2D, 0, WebGL.RGBA, image.width, image.height, 0,
      WebGL.RGBA, WebGL.UNSIGNED_BYTE, image.getBytes(), 0);

  return texture;
}
