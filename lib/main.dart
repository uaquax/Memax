import 'package:client/pages/create_meme_page.dart';
import 'package:client/pages/memes_page.dart';
import 'package:client/pages/my_profile_page.dart';
import 'package:client/pages/settings_page.dart';
import 'package:client/pages/sign_in_page.dart';
import 'package:client/services/colors.dart';
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
      themeMode: ThemeMode.dark,
      darkTheme: Themes.dark,
      home: const SignUpPage(),
      routes: {
        SignUpPage.route: (context) => const SignUpPage(),
        SignInPage.route: (context) => const SignInPage(),
        MemesPage.route: (context) => const MemesPage(),
        ProfilePage.route: (context) => const ProfilePage(),
        SettingsPage.route: (context) => const SettingsPage(),
        CreateMemePage.route: (context) => const CreateMemePage(),
        MyProfilePage.route: (context) => const MyProfilePage(),
      },
      initialRoute: SignUpPage.route,
    );
  }
}

class Themes {
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: kButtonMaterialColor,
    primaryColor: kButtonColor,
  );
}
