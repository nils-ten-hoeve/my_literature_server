import 'dart:io';


/// http://localhost:8080/?url=https://example.com
void main() async {
  await myLiteratureService();
}

Future<void> myLiteratureService() async {
   final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
   print('Service running on port:8080');
  
  await for (HttpRequest request in server) {
    request.response.headers.contentType = ContentType.text;
    // request.response.headers.add('Access-Control-Allow-Origin', '*');
    // request.response.headers.add('Access-Control-Allow-Methods', 'GET, OPTIONS');
    // request.response.headers.add('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
    // if (request.method == 'OPTIONS') {
    //   await request.response.close();
    //   return;
    // }
    final client = HttpClient();
    try {
      final uri = request.uri.queryParameters['url'];
      if (uri == null) {
        request.response.statusCode = HttpStatus.badRequest;
        request.response.write('Missing "url" query parameter.');
      } else {
        final targetUri = Uri.parse(uri);
        final targetRequest = await client.getUrl(targetUri);
        final targetResponse = await targetRequest.close();
        final contents = await targetResponse
            .transform(SystemEncoding().decoder)
            .join();
        request.response.write(contents);
      }
    } catch (e) {
      request.response.statusCode = HttpStatus.internalServerError;
      request.response.write('Error: $e');
    }
    await request.response.close();
    client.close();
  }
}

