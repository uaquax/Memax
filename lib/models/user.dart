import 'package:client/services/config.dart';

class User {
  String id;
  String userName;
  String userId;
  String avatar;
  String biography = "";

  User({
    required this.userName,
    this.userId = "",
    avatar,
    id,
  })  : avatar = avatar ?? "$SERVER_URL/default.jpg",
        id = id ?? "";
}
