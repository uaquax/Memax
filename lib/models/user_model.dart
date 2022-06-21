class UserModel {
  String? id;
  String userName;
  String userId;
  String email;
  String? jwt;
  String password;
  String avatar;
  String biography = "";

  UserModel(
      {required this.userName,
      this.email = "",
      this.password = "",
      this.userId = "",
      this.avatar = "https://memax.tublerzonestudi.repl.co/default.jpg",
      this.id,
      this.jwt = ""});

  static UserModel fromJson(json) {
    return UserModel(
      id: json["user"]['id'],
      userName: json["user"]['username'],
      email: json["user"]['email'],
      avatar: json["user"]['avatar'],
      jwt: json['accessToken'],
    );
  }
}
