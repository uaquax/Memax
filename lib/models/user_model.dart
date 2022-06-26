import 'package:client/services/config.dart';

class UserModel {
  String? id;
  String userName;
  String userId;
  String avatar;
  String biography = "";

  UserModel({
    required this.userName,
    this.userId = "",
    this.avatar = "$serverUrl/default.jpg",
    this.id,
  });
}
