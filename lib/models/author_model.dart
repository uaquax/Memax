import 'package:client/services/constants.dart';

class AuthorModel {
  String id;
  String userName;
  String userId;
  String avatar;
  bool isFollowed;

  AuthorModel({
    required this.id,
    required this.userName,
    this.userId = "",
    this.avatar = defaultAvatarUrl,
    this.isFollowed = false,
  });
}
