import 'package:client/pages/create_meme_page.dart';
import 'package:client/pages/memes_page.dart';
import 'package:client/pages/settings_page.dart';
import 'package:client/pages/sign_in_page.dart';
import 'package:client/services/config.dart';
import 'package:flutter/material.dart';
import 'pages/profile_page.dart';
import 'pages/sign_up_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
        ProfilePage.route: (context) => const ProfilePage(id: ""),
        SettingsPage.route: (context) => const SettingsPage(),
        CreateMemePage.route: (context) => const CreateMemePage(),
      },
      initialRoute: SignUpPage.route,
    );
  }
}

class Themes {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    primarySwatch: ThemeColors.buttonMaterialColor,
    splashColor: splashColor,
    primaryColor: splashColor,
  );
}
