import 'package:client/pages/memes_page.dart';
import 'package:client/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

import 'pages/profile_page.dart';
import 'pages/sign_up_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SignUpPage(),
      routes: {
        SignUpPage.route: (context) => const SignUpPage(),
        SignInPage.route: (context) => const SignInPage(),
        MemesPage.route: (context) => const MemesPage(),
        ProfilePage.route: (context) => const ProfilePage(),
      },
      initialRoute: SignUpPage.route,
    );
  }
}
