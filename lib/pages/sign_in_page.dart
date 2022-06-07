import 'dart:convert';

import 'package:client/pages/memes_page.dart';
import 'package:client/pages/sign_up_page.dart';
import 'package:client/services/server_service.dart';
import 'package:client/widgets/components/input_box.dart';
import 'package:client/widgets/components/link_button.dart';
import 'package:client/widgets/sign/sign_button.dart';
import 'package:client/widgets/sign/sign_header.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            SignInput(
                hintText: "Email or Username", controller: _emailController),
            SignInput(
              hintText: "Password",
              controller: _passwordController,
              isObscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            SignButton(
              text: "Sign In",
              onPressed: _signIn,
            ),
            LinkButton(
                text: "Don't have an account?",
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpPage.route);
                }),
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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", jsonDecode(user)["id"]);

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    Navigator.of(context).pushNamed(MemesPage.route);
  }
}
