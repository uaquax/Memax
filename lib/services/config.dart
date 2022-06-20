import 'package:flutter/material.dart';

const String serverUrl = "https://memax.lebedaefff.repl.co/";
const String usersUrl = "https://memax.lebedaefff.repl.co/api/users/";
const String signUpUrl = "https://memax.lebedaefff.repl.co/api/sign-up/";
const String signInUrl = "https://memax.lebedaefff.repl.co/api/sign-in/";
const String defaultAvatarUrl = "https://memax.lebedaefff.repl.co/default.jpg";
const String memesUrl = "https://memax.lebedaefff.repl.co/api/posts";
const String createMemeUrl =
    "https://memax.lebedaefff.repl.co/api/create-post/";

const Color splashColor = Color.fromARGB(255, 68, 71, 90);
const Color buttonColor = Color.fromARGB(255, 113, 116, 147);
const Color backgroundColor = Color.fromARGB(255, 40, 42, 54);
const Color textColor = Color.fromARGB(255, 248, 248, 242);
const Color grey = Color.fromARGB(255, 128, 128, 128);

const String kId = "id";
const String kJWT = "jwt";

const String authorizationToken =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBxQG1haWwucnUiLCJpZCI6IjYyYTMzMmU0YWJkMTY4M2E5YWM4MjEyNSIsImlzQWN0aXZhdGVkIjpmYWxzZSwidXNlcm5hbWUiOiJzZGFzZGFzZGFzZCIsImF2YXRhciI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTAwMC9kZWZhdWx0LmpwZyIsImJpb2dyYXBoeSI6IiIsImNyZWF0aW9uRGF0ZSI6IjIwMjItMDYtMTAiLCJpYXQiOjE2NTUyMDEzMDcsImV4cCI6MTY1NTIwMjIwN30.Cj4ODAbCnXnhDQjNyYstN1jcXjk8bH0ZF7EBZawaA84";

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
