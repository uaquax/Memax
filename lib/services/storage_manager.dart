import 'package:client/services/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageManager {
  static const _storage = FlutterSecureStorage();

  static void saveJWT(String jwt) async {
    if (jwt.isEmpty == false) {
      await _storage.write(key: kJWT, value: jwt);
    }
  }

  static void saveId(String id) async {
    if (id.isEmpty == false) {
      await _storage.write(key: kId, value: id);
    }
  }

  static void saveRefreshToken(String refreshToken) async {
    if (refreshToken.isEmpty == false) {
      await _storage.write(key: kRefreshToken, value: refreshToken);
    }
  }

  static Future<String> getRefreshToken() async {
    return await _storage.read(key: kRefreshToken) ?? "";
  }

  static Future<String> getJWT() async {
    return await _storage.read(key: kJWT) ?? "";
  }

  static Future<String> getId() async {
    return await _storage.read(key: kId) ?? "";
  }

  static void clear() async {
    await _storage.deleteAll();
  }
}
