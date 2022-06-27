import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageManager {
  static const _storage = FlutterSecureStorage();

  static void saveJWT(String jwt) async {
    final a = dotenv.env['JWT'];
    if (jwt.isEmpty == false) {
      await _storage.write(key: dotenv.env["JWT_KEY"] ?? "", value: jwt);
    }
  }

  static void saveId(String id) async {
    if (id.isEmpty == false) {
      await _storage.write(key: dotenv.env["ID_KEY"] ?? "", value: id);
    }
  }

  static void saveRefreshToken(String refreshToken) async {
    if (refreshToken.isEmpty == false) {
      await _storage.write(
          key: dotenv.env["REFRESH_TOKEN_KEY"] ?? "", value: refreshToken);
    }
  }

  static Future<String> getRefreshToken() async {
    return await _storage.read(key: dotenv.env["REFRESH_TOKEN_KEY"] ?? "") ??
        "";
  }

  static Future<String> getJWT() async {
    return await _storage.read(key: dotenv.env["JWT_KEY"] ?? "") ?? "";
  }

  static Future<String> getId() async {
    return await _storage.read(key: dotenv.env["ID_KEY"] ?? "") ?? "";
  }

  static void clear() async {
    await _storage.deleteAll();
  }
}
