import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const SignButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
            textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w400))),
        child: Text(text),
      ),
    );
  }
}
