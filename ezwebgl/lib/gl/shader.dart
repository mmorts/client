part of 'gl.dart';

class GlType {
  final int id;

  final String name;

  const GlType({this.id, this.name});

  static const GlType float = GlType(id: WebGL.FLOAT, name: "float");
}

class ShaderProgram {
  final RenderingContext2 gl;

  final Shader vertex;

  final Shader fragment;

  final Program program;

  final VertexArrayObject vao;

  ShaderProgram(
      {@required this.gl,
      @required this.vertex,
      @required this.fragment,
      @required this.program,
      @required this.vao});

  Uniform getUniform(String name) {
    final UniformLocation location = gl.getUniformLocation(program, name);
    // TODO what if it is null
    return Uniform(program: this, location: location);
  }

  AttributeLocation getVertexAttribute(String name) {
    final int attribLocation = gl.getAttribLocation(program, name);
    return AttributeLocation(location: attribLocation, program: this);
  }

  void use() {
    gl.useProgram(program);
    gl.bindVertexArray(vao);
  }

  void setUniform1f(String name, num x) {
    getUniform(name).set1f(x);
  }

  void setUniformMatrix4fv(String name, Mat4 matrix, {bool transpose: true}) {
    var loc = gl.getUniformLocation(program, name);
    gl.uniformMatrix4fv(loc, transpose, matrix.values);
  }

  void dispose() {
    gl.deleteShader(vertex);
    gl.deleteShader(fragment);
    gl.deleteProgram(program);
  }

  final attributes = <String, int>{};

  /// [size] specifies the number of components of type [type] in the attribute.
  void addAttribute(String name,
      {int size: 3,
      GlType type: GlType.float,
      bool normalize = false,
      int stride: 0,
      int offset: 0}) {
    final attrib = gl.getAttribLocation(program, name);
    // Setup attributes
    gl.enableVertexAttribArray(attrib);
    gl.vertexAttribPointer(
      attrib,
      size,
      type.id,
      normalize,
      stride,
      offset,
    );
  }

  static ShaderProgram prepare(
      {@required RenderingContext2 gl,
      @required String vertex,
      @required String fragment}) {
    // TODO Handle exceptions
    final Shader vertexShader = compileShader(gl, WebGL.VERTEX_SHADER, vertex);
    final Shader fragmentShader =
        compileShader(gl, WebGL.FRAGMENT_SHADER, fragment);
    final Program program = createProgram(gl, vertexShader, fragmentShader);

    final vao = gl.createVertexArray();
    gl.bindVertexArray(vao);

    return ShaderProgram(
        gl: gl,
        program: program,
        vertex: vertexShader,
        fragment: fragmentShader,
        vao: vao);
  }

  static Shader compileShader(
      RenderingContext2 gl, int shaderType, String source) {
    Shader shader = gl.createShader(shaderType);
    gl.shaderSource(shader, source);
    gl.compileShader(shader);
    final bool success = gl.getShaderParameter(shader, WebGL.COMPILE_STATUS);
    if (success) return shader;
    final msg = gl.getShaderInfoLog(shader);
    gl.deleteShader(shader);
    throw Exception("Compilation failed! ${msg}"); // TODO add message
  }

  static Program createProgram(
      RenderingContext2 gl, Shader vertex, Shader fragment) {
    Program program = gl.createProgram();
    gl.attachShader(program, vertex);
    gl.attachShader(program, fragment);
    gl.linkProgram(program);
    var success = gl.getProgramParameter(program, WebGL.LINK_STATUS);
    if (success) return program;

    // TODO console.log(gl.getProgramInfoLog(program));
    gl.deleteProgram(program);

    throw Exception();
  }
}
