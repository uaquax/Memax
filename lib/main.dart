import 'package:client/pages/memes_page.dart';
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
      themeMode: ThemeMode.light,
      theme: Themes.light,
      darkTheme: Themes.dark,
      home: const SignUpPage(),
      routes: {
        SignUpPage.route: (context) => const SignUpPage(),
        SignInPage.route: (context) => const SignInPage(),
        MemesPage.route: (context) => const MemesPage(),
        ProfilePage.route: (context) => const ProfilePage(),
        SettingsPage.route: (context) => const SettingsPage(),
      },
      initialRoute: SignUpPage.route,
    );
  }
}

class Themes {
  static final ThemeData light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: kButtonColor,
    primarySwatch: kButtonMaterialColor,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
      button: TextStyle(color: Colors.black),
      caption: TextStyle(color: Colors.black),
      headline1: TextStyle(color: Colors.black),
      headline2: TextStyle(color: Colors.black),
      headline3: TextStyle(color: Colors.black),
      headline4: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
      subtitle1: TextStyle(color: Colors.black),
      subtitle2: TextStyle(color: Colors.black),
      overline: TextStyle(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );

  static final ThemeData dark = ThemeData(
    backgroundColor: kBackgroundColor,
    primaryColor: kButtonColor,
    primarySwatch: kButtonMaterialColor,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      button: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.white),
      headline1: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.white),
      overline: TextStyle(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
