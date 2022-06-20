import 'package:client/pages/memes_page.dart';
import 'package:client/pages/sign_up_page.dart';
import 'package:client/services/server_service.dart';
import 'package:client/services/storage_manager.dart';
import 'package:client/widgets/components/input_box.dart';
import 'package:client/widgets/components/link_button.dart';
import 'package:client/widgets/components/password_box.dart';
import 'package:client/widgets/sign/sign_button.dart';
import 'package:client/widgets/sign/sign_header.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  static const String route = "/sign_in";

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            const SignHeader(),
            const SizedBox(
              height: 30,
            ),
            SignInput(hintText: "Email", controller: _emailController),
            PasswordBox(
              hintText: "Password",
              controller: _passwordController,
              topPadding: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            SignButton(
              text: "Sign In",
              onPressed: _signIn,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                LinkButton(
                    text: "Sign Up",
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignUpPage.route);
                    }),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
    );
  }

  Future<void> _signIn() async {
    final user = await ServerService.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );

    StorageManager.saveId(user.id ?? "");
    StorageManager.saveJWT(user.jwt ?? "");

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    Navigator.of(context).pushNamed(MemesPage.route);
  }
}
