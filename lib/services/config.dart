import 'package:flutter/material.dart';

const String apiUrl = "https://Memax-1.tublerzonestudi.repl.co/api";
const String serverUrl = "https://Memax-1.tublerzonestudi.repl.co";
// const String usersUrl = "${baseUrl}user/";
// const String signUpUrl = "${baseUrl}sign-up/";
// const String signInUrl = "${baseUrl}sign-in/";
// const String defaultAvatarUrl =
//     "https://Memax-1.tublerzonestudi.repl.co/default.jpg";
// const String memesUrl = "${baseUrl}posts";
// const String userMemesUrl = "${baseUrl}posts/user/";
// const String createMemeUrl = "${baseUrl}create-post";
// const String refreshTokenUrl = "${baseUrl}refresh/mobile";
// const String likeMemeUrl = "${baseUrl}change-like-status";
// const String addCommentUrl = "${baseUrl}create-comment";

const Color splashColor = Color.fromARGB(255, 68, 71, 90);
const Color buttonColor = Color.fromARGB(255, 113, 116, 147);
const Color backgroundColor = Color.fromARGB(255, 40, 42, 54);
const Color textColor = Color.fromARGB(255, 248, 248, 242);
const Color grey = Color.fromARGB(255, 128, 128, 128);

const String kId = "id";
const String kJWT = "jwt";
const String kRefreshToken = "refreshToken";

class ThemeColors {
  static const Map<int, Color> _buttonColor = {
    50: buttonColor,
    100: buttonColor,
    200: buttonColor,
    300: buttonColor,
    400: buttonColor,
    500: buttonColor,
    600: buttonColor,
    700: buttonColor,
    800: buttonColor,
    900: buttonColor,
  };
  static const MaterialColor buttonMaterialColor =
      MaterialColor(0xFF6c6f8d, _buttonColor);
}
