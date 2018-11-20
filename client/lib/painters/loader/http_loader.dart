import 'package:http/http.dart';
import 'loader.dart';

class HttpIo implements Io {
  final Client client;

  HttpIo(this.client);

  @override
  Future<List<int>> readSpriteFile(String sprite, String file) async {
    final resp = await client.get("/assets/sprite/$sprite/$file");
    if (resp.statusCode != 200)
      throw Exception("Request failed with status code: ${resp.statusCode}");
    return resp.bodyBytes;
  }
}
