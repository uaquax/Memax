import 'dart:convert';
import 'package:client/models/meme_model.dart';
import 'package:client/models/user_model.dart';
import 'package:client/services/config.dart';
import 'package:client/services/storage_manager.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ServerService {
  static final Dio _dio = Dio();
  static signUp({required UserModel user}) async {
    try {
      FormData data = FormData.fromMap(
        {
          'email': user.email,
          'username': user.userName,
          'password': user.password,
        },
      );
      final response = await _dio.post(
        signUpUrl,
        data: data,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  static getUser({required String id}) async {
    if (id.isEmpty == false) {
      try {
        final response = await _dio.get(
          usersUrl + id,
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        );
        if (response.statusCode == 200) {
          return response.data;
        } else {
          throw Exception(response.statusCode.toString());
        }
      } catch (e) {
        throw Exception("$e");
      }
    } else {
      return null;
    }
  }

  static Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      final response = await http.post(Uri.parse(signInUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "email": email,
            "password": password,
          }));
      if (response.statusCode == 200 && response.body is String) {
        final responseJson = response.body is String
            ? await json.decode(response.body)["user"]
            : "";
        return UserModel.fromJson(responseJson);
      } else {
        throw Exception(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  static getMemes() async {
    try {
      // final response = await http.get(
      //   Uri.parse(memesUrl),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //     'Authorization': 'Bearer ${await StorageManager.getJWT()}',
      //   },
      // );
      final response = await _dio.get(
        memesUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await StorageManager.getJWT()}',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  static createMeme(MemeModel meme) async {
    try {
      final accessToken = await StorageManager.getJWT();
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
      final response = await _dio.post(
        createMemeUrl,
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
          headers: {
            'Authorization': "Bearer $accessToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        throw Exception(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}
