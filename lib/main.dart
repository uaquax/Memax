import 'package:client/pages/settings/settings_page.dart';
import 'package:client/pages/sign/sign_in_page.dart';
import 'package:client/pages/sign/sign_up_page.dart';
import 'package:client/services/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/memes/create_meme_page.dart';
import 'pages/memes/memes_page.dart';
import 'pages/profile/profile_page.dart';

void main() async {
  await dotenv.load();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: Themes.dark,
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
