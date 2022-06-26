import 'package:client/models/auth_model.dart';
import 'package:client/models/user_model.dart';
import 'package:client/pages/sign_in_page.dart';
import 'package:client/services/config.dart';
import 'package:client/services/dialogs.dart';
import 'package:client/pages/memes_page.dart';
import 'package:client/services/api.dart';
import 'package:client/services/storage_manager.dart';
import 'package:client/widgets/components/input_box.dart';
import 'package:client/widgets/components/link_button.dart';
import 'package:client/widgets/components/password_box.dart';
import 'package:client/widgets/sign/sign_button.dart';
import 'package:client/widgets/sign/sign_header.dart';
import 'package:flutter/material.dart';

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

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _getUser();
  }

  void _getUser() async {
    setState(() {
      isLoading = true;
    });

    final refreshToken = await StorageManager.getRefreshToken();

    if (refreshToken.isEmpty == false) {
      await Future.delayed(const Duration(milliseconds: 0));
      if (!mounted) return;

      Navigator.of(context).pushNamed(MemesPage.route);
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading == false
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                const SignHeader(),
                SignInput(
                    hintText: "Email",
                    topPadding: 15,
                    controller: _emailController),
                SignInput(
                    hintText: "Username",
                    topPadding: 15,
                    controller: _usernameController),
                PasswordBox(
                  hintText: "Password",
                  controller: _passwordController,
                  topPadding: 15,
                ),
                PasswordBox(
                  hintText: "Confirm password",
                  topPadding: 15,
                  controller: _confirmPasswordController,
                ),
                const SizedBox(
                  height: 15,
                ),
                SignButton(text: "Sign Up", onPressed: _signUp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    LinkButton(
                      text: "Sign In",
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignInPage.route);
                      },
                    )
                  ],
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _signUp() async {
    if (_passwordController.text == _confirmPasswordController.text &&
        _passwordController.text.length > 6 &&
        _usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _emailController.text.isValidEmail()) {
      try {
        final response = await API.signUp(
            user: AuthModel(
                email: _emailController.text,
                userName: _usernameController.text,
                password: _passwordController.text));

        await Future.delayed(const Duration(milliseconds: 5));
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
