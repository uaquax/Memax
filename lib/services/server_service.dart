// ignore_for_file: unnecessary_type_check

import 'dart:convert';
import 'package:client/models/user_model.dart';
import 'package:client/services/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ServerService {
  static Future<UserModel> signUp({required UserModel user}) async {
    try {
      final response = await http.post(Uri.parse(signUpUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "email": user.email,
            "username": user.userName,
            "password": user.password,
            "biography": user.biography,
            "creationDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          }));
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
      throw Exception("id is empty");
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
}
