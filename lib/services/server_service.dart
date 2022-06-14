import 'dart:convert';
import 'package:client/models/user_model.dart';
import 'package:client/services/constants.dart';
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
          'Authorization':
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBxQG1haWwucnUiLCJpZCI6IjYyYTMzMmU0YWJkMTY4M2E5YWM4MjEyNSIsImlzQWN0aXZhdGVkIjpmYWxzZSwidXNlcm5hbWUiOiJzZGFzZGFzZGFzZCIsImF2YXRhciI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTAwMC9kZWZhdWx0LmpwZyIsImJpb2dyYXBoeSI6IiIsImNyZWF0aW9uRGF0ZSI6IjIwMjItMDYtMTAiLCJpYXQiOjE2NTUyMDEzMDcsImV4cCI6MTY1NTIwMjIwN30.Cj4ODAbCnXnhDQjNyYstN1jcXjk8bH0ZF7EBZawaA84"
        },
      );

      if (response.statusCode == 200 && response.body is String) {
        print(response);
        final responseJson =
            response.body is String ? await json.decode(response.body) : "";
        return responseJson["docs"];
      } else {
        throw Exception(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  static createMeme(List<int> meme) async {
    try {
      final response = await http.post(Uri.parse(createMemeUrl), body: meme);
    } catch (e) {
      throw Exception("$e");
    }
  }
}
