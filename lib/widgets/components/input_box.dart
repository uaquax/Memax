import 'package:client/services/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignInput extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final double topPadding;

  SignInput({
    Key? key,
    required this.hintText,
    this.topPadding = 10,
    required this.controller,
  }) : super(key: key);

  @override
  State<SignInput> createState() => _SignInputState();
}

class _SignInputState extends State<SignInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: widget.topPadding),
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
      child: TextField(
          cursorColor: textColor,
          controller: widget.controller,
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hintText: widget.hintText,
          )),
    );
  }

  String getText() => widget.controller.text;
}
