import 'package:client/colors.dart';
import 'package:client/pages/sign_up_page.dart';
import 'package:client/widgets/header.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  static const String route = "/sign_in";

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        const SizedBox(height: 10),
        const Header(),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
          child: const TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Email or Username",
          )),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
          child: const TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Password",
          )),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 220,
          height: 52,
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kButtonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36.0),
                )),
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w400))),
            child: const Text("Sign In"),
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SignUpPage.route);
            },
            child: const Text(
              "Don't have account?",
              style: TextStyle(decoration: TextDecoration.underline),
            )),
        const SizedBox(
          height: 10,
        ),
        const Text("or"),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kBackgroundColor)),
                child: Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  color: kBackgroundColor,
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/google.png",
                        height: 25,
                      ),
                      const SizedBox(width: 10),
                      const Text("Conitnue with Google"),
                    ],
                  ),
                )),
          ),
        ),
      ]),
    );
  }
}
