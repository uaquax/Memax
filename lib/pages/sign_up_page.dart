import 'package:client/colors.dart';
import 'package:client/pages/sign_in_page.dart';
import 'package:client/widgets/header.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static const String route = "/sign_up";

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        const SizedBox(height: 10),
        const Header(),
        Container(
          padding: EdgeInsets.only(top: 15),
          margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
          child: const TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Email",
          )),
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
          child: const TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "User Name",
          )),
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
          child: const TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Password",
          )),
        ),
        Container(
          padding: EdgeInsets.only(top: 15, bottom: 10),
          margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
          child: const TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Confirm Password",
          )),
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
            child: const Text("Sign Up"),
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SignInPage.route);
            },
            child: const Text(
              "Already have an account?",
              style: TextStyle(decoration: TextDecoration.underline),
            )),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kBackgroundColor)),
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
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
