import 'dart:io';

void main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
  print('Server running on port ${server.port}');

  await for (HttpRequest request in server) {
    request.response
      ..write('Hello from Dart server!')
      ..close();
  }
}
