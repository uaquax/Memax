import 'dart:convert';
import 'package:client/models/meme_model.dart';
import 'package:client/models/user_model.dart';
import 'package:client/services/config.dart';
import 'package:client/services/storage_manager.dart';
import 'package:http/http.dart' as http;

class ServerService {
  static Future<UserModel> signUp({required UserModel user}) async {
    try {
      final response = await http.post(
        Uri.parse(signUpUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": user.email,
          "username": user.userName,
          "password": user.password,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseJson =
            response.body is String ? await json.decode(response.body) : null;
        return UserModel.fromJson(responseJson['user']);
      } else {
        throw Exception(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  static Future<UserModel> getUser({required String id}) async {
    if (id.isEmpty == false) {
      try {
        final response = await http.get(Uri.parse(usersUrl + id));
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseJson = response.body is String
              ? await json.decode(response.body)["user"]
              : null;
          return UserModel.fromJson(responseJson);
        } else {
          throw Exception(response.statusCode.toString());
        }
      } catch (e) {
        throw Exception("$e");
      }
    } else {
      return UserModel(userName: "");
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
      final response = await http.get(
        Uri.parse(memesUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authorizationToken
        },
      );

      if (response.statusCode == 200 && response.body is String) {
        print(
            "Type is String = -> ${response.body is String} \n\n ${response.body}");
        final responseJson =
            response is String ? await json.decode(response.body) : "";
        return responseJson;
      } else {
        throw Exception(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  static createMeme(MemeModel meme) async {
    try {
      final String id = await StorageManager.getId();
      final Map<String, dynamic> body = <String, dynamic>{
        "title": meme.title,
        "description": meme.description,
        "author": id,
        "picture": meme.file!.path,
      };

      final http.Response response = await http.post(
        Uri.parse(createMemeUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authorizationToken
        },
        body: jsonEncode(body),
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
