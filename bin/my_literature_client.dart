import 'dart:io';

import 'package:my_literature_server/encryption.dart';

const String urlToLocalMyLiteratureServer = 'http://localhost:8080';

/// using render.com
const String urlToRemoteMyLiteratureServer =
    'https://my-literature-server.onrender.com';
const String urlToRead = 'https://example.com';

Future<void> main(List<String> args) async {
  print(
    await fetchMyLiteratureText(
      urlToMyLiteratureServer: urlToLocalMyLiteratureServer,
      urlToRead: urlToRead,
    ),
  );
}

/// Contains a HttpClient that gets text from [myLiteratureService]
/// by opening http://localhost:8080/?url=https://example.com

/// and returning the response
///
/// * [urlToMyLiteratureServer] e.g.: http://localhost:8080/?url=https://example.com
///   or https://my-literature-server.onrender.com/?url=https://example.com
/// * [urlToRead] e.g.: https://example.com
Future<String> fetchMyLiteratureText({
  required String urlToMyLiteratureServer,
  required String urlToRead,
}) async {
  final client = HttpClient();
  try {
    final String encodedUrlToRead = Uri.encodeComponent(
      encryptString(urlToRead),
    );
    final uri = Uri.parse('$urlToMyLiteratureServer/?url=$encodedUrlToRead');
    print('Getting: $uri');
    final request = await client.getUrl(uri);
    final response = await request.close();
    final contents = await response.transform(SystemEncoding().decoder).join();
    return contents;
  } catch (e) {
    rethrow;
  } finally {
    client.close();
  }
}
