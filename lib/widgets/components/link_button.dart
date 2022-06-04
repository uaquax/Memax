import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const LinkButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(decoration: TextDecoration.underline),
        ));
  }
}
