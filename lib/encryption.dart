import 'package:encrypt/encrypt.dart' as encrypt;

/// Replace with your own 32-character key and 16-character IV for production use.
final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
final _iv = encrypt.IV.fromUtf8('8bytesiv12345678');

/// Encryption is the process of converting information into a
/// secret code (cipher text) that can only be deciphered with
/// a key, making it unreadable to unauthorized individuals.
String encryptString(String plainText) {
  final encrypter = encrypt.Encrypter(encrypt.AES(_key));
  final encrypted = encrypter.encrypt(plainText, iv: _iv);
  return encrypted.base64;
}

/// Decryption is a process that transforms
/// encrypted information into its original format.
String decryptString(String encryptedText) {
  final encrypter = encrypt.Encrypter(encrypt.AES(_key));
  final decrypted = encrypter.decrypt64(encryptedText, iv: _iv);
  return decrypted;
}
