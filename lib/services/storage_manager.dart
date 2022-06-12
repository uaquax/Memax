import 'package:client/services/constants.dart';
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

  static Future<String> getJWT() async {
    return await _storage.read(key: kJWT) ?? "";
  }

  static Future<String> getId() async {
    return await _storage.read(key: kId) ?? "";
  }
}
