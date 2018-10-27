import 'dart:html';
import 'dart:web_gl';
import 'dart:async';

import 'dart:typed_data';

import 'package:client/ezwebgl/ezwebgl.dart';

final String mapVertexShader = r"""
#version 300 es

layout(location = 0) in vec2 a_plus;
layout(location = 1) in vec4 a_position;

void main() {
  gl_Position = vec4(a_position.x + a_plus.x, a_position.y + a_plus.y, a_position.z, a_position.w);
}
""";

final String mapFragmentShader = r"""
#version 300 es

precision mediump float;
 
// we need to declare an output for the fragment shader
out vec4 outColor;
 
void main() {
  outColor = vec4(1, 0, 0, 1);
}
""";

void main() {
  CanvasElement gameCanvas = querySelector("#game-canvas");
  RenderingContext2 gl = gameCanvas.getContext("webgl2");

  ShaderProgram mapShader;
  Buffer positionBuffer;
  Texture texture;

  Function init = () {
    // Create and bind VBO
    positionBuffer = gl.createBuffer();
    gl.bindBuffer(WebGL.ARRAY_BUFFER, positionBuffer);

    mapShader = ShaderProgram.prepare(
        gl: gl, vertex: mapVertexShader, fragment: mapFragmentShader);

    mapShader.addAttribute("a_plus", size: 2, stride: 6 * 4, offset: 4 * 4);
    mapShader.addAttribute("a_position", size: 4, stride: 6 * 4);

    texture = gl.createTexture();
    gl.bindTexture(WebGL.TEXTURE_2D, texture);
    gl.texImage2D2(
        WebGL.TEXTURE_2D,
        0,
        WebGL.RGBA,
        2,
        2,
        0,
        WebGL.RGBA,
        WebGL.UNSIGNED_BYTE,
        Uint8List.fromList([
          1, 1, 1, 1, //
          1, 1, 1, 1, //
          0, 1, 1, 1, //
          0, 1, 1, 1, //
        ]));

    // TODO setup uniform
  };

  document.onLoad.listen((_) {
    // TODO also on resize
    gameCanvas.width = gameCanvas.clientWidth;
    gameCanvas.height = gameCanvas.clientHeight;
    gl.viewport(0, 0, gameCanvas.clientWidth, gameCanvas.clientHeight);
  });

  init();

  Function loop = () {
    gl.clearColor(0, 0, 0, 1);
    gl.clear(WebGL.COLOR_BUFFER_BIT);

    final positions = DataArray()
      ..add(DrawData(
          position: Vec4(x: 0.0, y: 0.0, z: 0.0, w: 1.0),
          plus: Vec2(x: 0.0, y: 0.0)))
      ..add(DrawData(
          position: Vec4(x: 0.0, y: 0.9, z: 0.0, w: 1.0),
          plus: Vec2(x: 0.1, y: 0.0)));
    gl.bufferData(WebGL.ARRAY_BUFFER, positions.toBuffer(), WebGL.STATIC_DRAW);

    mapShader.use();

    gl.drawArrays(WebGL.LINES, 0, 2);
  };

  loop();
  Timer.periodic(Duration(seconds: 5), (_) => loop());
}

class DrawData implements GlData {
  final Vec4 position;

  final Vec2 plus;

  DrawData({this.position, this.plus});

  @override
  List<Vec> get asGlData {
    return [position, plus];
  }
}
