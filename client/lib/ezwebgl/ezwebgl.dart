import 'dart:async';
import 'dart:web_gl';
import 'dart:typed_data';

import 'package:meta/meta.dart';

import 'package:jaguar_resty/jaguar_resty.dart' as resty;
import 'package:image/image.dart' as imTools;

part 'shader.dart';
part 'texture.dart';
part 'vec.dart';

class Uniform {
  final ShaderProgram program;

  final UniformLocation location;

  Uniform({this.program, this.location});

  void set1f(num x) {
    gl.uniform1f(location, x);
  }

  RenderingContext2 get gl => program.gl;
}

class AttributeLocation {
  final int location;

  final ShaderProgram program;

  AttributeLocation({this.location, this.program});

  RenderingContext2 get gl => program.gl;
}