import 'package:client/models/user_model.dart';
import 'package:client/pages/sign_in_page.dart';
import 'package:client/services/constants.dart';
import 'package:client/services/dialogs.dart';
import 'package:client/pages/memes_page.dart';
import 'package:client/services/server_service.dart';
import 'package:client/widgets/components/input_box.dart';
import 'package:client/widgets/sign/sign_button.dart';
import 'package:client/widgets/sign/sign_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpPage extends StatefulWidget {
  static const String route = "/sign_up";

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          const SignHeader(),
          SignInput(
              hintText: "Email", topPadding: 15, controller: _emailController),
          SignInput(
              hintText: "Username",
              topPadding: 15,
              controller: _usernameController),
          SignInput(
              hintText: "Password",
              topPadding: 15,
              controller: _passwordController,
              isObscureText: true),
          SignInput(
              hintText: "Confirm password",
              topPadding: 15,
              controller: _confirmPasswordController,
              isObscureText: true),
          const SizedBox(
            height: 10,
          ),
          SignButton(text: "Sign Up", onPressed: _signUp),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SignInPage.route);
              },
              child: const Text(
                "Already have an account?",
                style: TextStyle(decoration: TextDecoration.underline),
              )),
        ],
      ),
    );
  }

  Future<void> _signUp() async {
    if (_passwordController.text == _confirmPasswordController.text &&
        _passwordController.text.length > 8 &&
        _usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _emailController.text.isValidEmail()) {
      try {
        final UserModel user = await ServerService.signUp(
            user: UserModel(
                email: _emailController.text,
                userName: _usernameController.text,
                password: _passwordController.text,
                userId: ""));

        const storage = FlutterSecureStorage();
        await storage.write(key: kId, value: user.id);
        await storage.write(key: kToken, value: user.token);

        showSuccess(
            context: context,
            title: "Success",
            message: "You have successfully signed up!");

        await Future.delayed(const Duration(milliseconds: 200));
        if (!mounted) return;

        Navigator.of(context).pushNamed(MemesPage.route);
      } catch (e) {
        showError(
            context: context, title: "Sign up failed", error: e.toString());
      }
    } else {
      showError(
          context: context,
          title: "Sign up failed",
          error: "Please check your input");
    }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
