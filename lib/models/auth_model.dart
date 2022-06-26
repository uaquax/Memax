class AuthModel {
  String email;
  String password;
  String userName;

  AuthModel({required this.email, required this.password, this.userName = ""});
}
