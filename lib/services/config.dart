import 'package:flutter_dotenv/flutter_dotenv.dart';

final String? SERVER_URL = dotenv.env["SERVER_URL"];
final String? API_URL = dotenv.env["API_URL"];
final String? JWT_KEY = dotenv.env["JWT_KEY"];
final String? ID_KEY = dotenv.env["ID_KEY"];
final String? REFRESH_TOKEN_KEY = dotenv.env["REFRESH_TOKEN_KEY"];
