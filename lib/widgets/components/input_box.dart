import 'package:flutter/material.dart';

class SignInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double topPadding;

  const SignInput(
      {Key? key,
      required this.hintText,
      this.topPadding = 10,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
          )),
    );
  }

  String getText() => controller.text;
}
