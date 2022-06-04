import 'package:client/pages/memes_page.dart';
import 'package:client/services/constants.dart';
import 'package:flutter/material.dart';

class SignWithGoogle extends StatelessWidget {
  const SignWithGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: ElevatedButton(
            onPressed: () async {
              // GoogleSignApi.currentUser = await GoogleSignApi.signIn();
              // print(GoogleSignApi.currentUser?.displayName);
              Navigator.of(context).pushNamed(MemesPage.route);
            },
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
                  const Text("Continue with Google"),
                ],
              ),
            )),
      ),
    );
  }
}
