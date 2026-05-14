// lib/core/services/encryption_service.dart

import 'package:encrypt/encrypt.dart';

class EncryptionService {
  // 32 BYTE KEY
  static final Key _key = Key.fromUtf8(
    '12345678901234567890123456789012',
  );

  // FIXED IV
  static final IV _iv = IV.fromUtf8(
    '1234567890123456',
  );

  // AES
  static final Encrypter _encrypter =
      Encrypter(
    AES(
      _key,
      mode: AESMode.cbc,
    ),
  );

  // ENCRYPT
  static String encryptData(
    String text,
  ) {
    final encrypted =
        _encrypter.encrypt(
      text,
      iv: _iv,
    );

    return encrypted.base64;
  }

  // DECRYPT
  static String decryptData(
    String encryptedText,
  ) {
    return _encrypter.decrypt64(
      encryptedText,
      iv: _iv,
    );
  }
}