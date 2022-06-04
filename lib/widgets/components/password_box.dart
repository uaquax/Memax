import 'package:flutter/material.dart';

class SignPassword extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double topPadding;

  const SignPassword(
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
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
        validator: (String? value) {
          if (value!.trim().isEmpty) {
            return 'Password is required';
          } else if (value.length < 6 ||
              value.length > 20 ||
              value.contains(RegExp(r'[^a-zA-Z0-9]'))) {
            return 'Password must be 6-20 characters long and contain only letters and numbers';
          }
          return null;
        },
      ),
    );
  }

  String getText() => controller.text;
}
