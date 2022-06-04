import 'dart:convert';

import 'package:client/services/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ServerManager {
  static Future<String> signUp(String email, String username, String password,
      String confirmPassword) async {
    final response = await http.post(Uri.parse(signUpUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "username": username,
          "password": password,
          "creationDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        }));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Server unknown error");
    }
  }
}
