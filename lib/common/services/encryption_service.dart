import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  EncryptionService._();

  static String encryptMessage(String plainText, String pin) {
    final key = _getKeyFromPin(pin);
    final iv = encrypt.IV.fromSecureRandom(16);

    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    return '${iv.base64}:${encrypted.base64}';
  }

  static String? decryptMessage(String encryptedData, String pin) {
    try {
      final parts = encryptedData.split(":");
      if (parts.length != 2) return null;

      final iv = encrypt.IV.fromBase64(parts[0]);
      final encrypted = encrypt.Encrypted.fromBase64(parts[1]);

      final key = _getKeyFromPin(pin);

      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc),
      );

      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to decrypt message.');
    }
  }

  static encrypt.Key _getKeyFromPin(String pin) {
    final hash = sha256.convert(utf8.encode(pin));
    return encrypt.Key.fromBase64(base64.encode(hash.bytes));
  }
}
