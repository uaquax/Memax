import 'package:client/services/config.dart';

class Author {
  final String id;
  final String userName;
  final String biography;
  final String avatar;
  final String userId;
  bool isFollowed;

  Author({
    required this.id,
    required this.userName,
    biography,
    avatar,
    userId,
    isFollowed,
  })  : biography = biography ?? '',
        avatar = avatar ?? "$SERVER_URL/default.jpg",
        userId = userId ?? '',
        isFollowed = isFollowed ?? false;
}
