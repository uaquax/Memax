import 'dart:convert';

import 'package:client/models/auth_model.dart';
import 'package:client/models/meme_model.dart';
import 'package:client/services/config.dart';
import 'package:client/services/storage_manager.dart';
import 'package:dio/dio.dart';

class API {
  int count = 0;
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: apiUrl,
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          final token = await StorageManager.getJWT();
          if (token.isEmpty == false) {
            request.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(request);
        },
        onError: (error, handler) async {
          print("<- ERROR -> 401");
          if (error.response?.statusCode == 401) {
            final token = await StorageManager.getJWT();
            if (token.isNotEmpty) {
              await refreshToken();

              return handler.resolve(await _retry(error.requestOptions));
            }
          }
          return handler.next(error);
        },
      ),
    );

  static Future<Map?> getUser({required String id}) async {
    final response = await _dio.get("/user/$id");

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      return response.data;
    }
    return null;
  }

  static Future<Map?> signUp({required AuthModel user}) async {
    try {
      FormData data = FormData.fromMap(
        {
          'email': user.email,
          'username': user.userName,
          'password': user.password,
        },
      );
      final response = await _dio.post(
        "/sign-up",
        data: data,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'multipart/from-data; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        StorageManager.saveRefreshToken(response.data["refreshToken"]);
        StorageManager.saveJWT(response.data["accessToken"]);
        StorageManager.saveId(response.data["user"]["id"]);

        return response.data;
      } else {
        throw Exception(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  static Future<Map?> signIn({required AuthModel user}) async {
    final response = await _dio.post("/sign-in",
        data: jsonEncode({
          "email": user.email,
          "password": user.password,
        }));

    if (response.statusCode == 401 || response.statusCode == 403) {
      print("\n\n  <- Error -> 401~~ \n\n");
    }

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      StorageManager.saveRefreshToken(response.data["refreshToken"]);
      StorageManager.saveJWT(response.data["accessToken"]);
      StorageManager.saveId(response.data["user"]["id"]);

      return response.data;
    }
    return null;
  }

  static void createMeme({required MemeModel meme}) async {
    FormData formData = FormData.fromMap({
      "title": meme.title,
      "description": meme.description,
    });
    formData.files.add(
      MapEntry(
        "picture",
        await MultipartFile.fromFile(meme.file!.path,
            filename: meme.file!.path.split("/").last),
      ),
    );
    final Response response = await _dio.post("/create-post",
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer ${await StorageManager.getJWT()}',
        }));

    if (response.statusCode == 401 || response.statusCode == 403) {
      print("\n\n  <- Error -> 401~~ \n\n");
    }
  }

  static Future<Map?> getMemes({required int limit, required int page}) async {
    final Response response = await _dio.get("/posts?page=$page&limit=$limit");

    if (response.statusCode == 401 || response.statusCode == 403) {
      print("\n\n  <- Error -> 401~~ \n\n");
    }

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      return response.data;
    }
    return null;
  }

  static Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }

  static refreshToken() async {
    final token = await StorageManager.getRefreshToken();

    if (token.isNotEmpty) {
      final Response response = await _dio.post(
        "/refresh/mobile",
        options: Options(
          headers: {
            "refreshToken": token,
          },
        ),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 && response.data.isNotEmpty) {
        StorageManager.saveJWT(response.data["accessToken"]);
        StorageManager.saveRefreshToken(response.data["refreshToken"]);

        return response.data;
      } else {
        StorageManager.clear();
      }
    }
  }

  static Future<Map?> changeLikeStatus(String memeId) async {
    final Response response = await _dio.post("/change-like-status", data: {
      "id": memeId,
    });

    if (response.statusCode == 401 || response.statusCode == 403) {
      print("\n\n  <- Error -> 401~~ \n\n");
    }

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      return response.data;
    }
    return null;
  }

  static Future<Map?> getUserMemes(
      {required String id, required int limit}) async {
    final Response response =
        await _dio.get("/posts/user/$id?limit=$limit&page=1");

    if (response.statusCode == 401 || response.statusCode == 403) {
      print("\n\n  <- Error -> 401~~ \n\n");
    }

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      return response.data;
    }
    return null;
  }
}
