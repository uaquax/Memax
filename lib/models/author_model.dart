import 'package:client/services/config.dart';

class AuthorModel {
  String id;
  String userName;
  String userId;
  String avatar;
  bool isFollowed;
  bool isLiked = false;

  AuthorModel({
    required this.id,
    required this.userName,
    this.userId = "",
    this.avatar = defaultAvatarUrl,
    this.isFollowed = false,
  });
}
