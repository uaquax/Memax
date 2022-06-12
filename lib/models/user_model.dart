class UserModel {
  String? id;
  String userName;
  String userId;
  String email;
  String? jwt;
  String password;
  String avatar;
  String biography = "";

  UserModel({
    required this.userName,
    this.email = "",
    this.password = "",
    this.userId = "",
    this.avatar = "https://memax.tublerzonestudi.repl.co/default.jpg",
    this.id,
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        userName: json['username'],
        email: json['email'],
        avatar: json['avatar']);
  }
}
