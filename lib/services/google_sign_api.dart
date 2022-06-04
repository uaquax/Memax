import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignApi {
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  static late final GoogleSignInAccount? currentUser;

  static Future<GoogleSignInAccount?> signIn() => googleSignIn.signIn();
}
