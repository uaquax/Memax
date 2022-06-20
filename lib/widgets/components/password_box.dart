import 'package:client/services/config.dart';
import 'package:flutter/material.dart';

class PasswordBox extends StatefulWidget {
  final TextEditingController controller;
  String hintText;
  final double topPadding;

  PasswordBox(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.topPadding})
      : super(key: key);

  @override
  State<PasswordBox> createState() => _PasswordBoxState();
}

class _PasswordBoxState extends State<PasswordBox> {
  bool isPasswordVisible = false;
  bool isPasswordValidate = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.only(top: 15),
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
      child: TextField(
          cursorColor: textColor,
          enableInteractiveSelection: true,
          autocorrect: false,
          enableSuggestions: false,
          toolbarOptions: const ToolbarOptions(
            copy: false,
            paste: false,
            cut: false,
            selectAll: false,
          ),
          obscureText: !isPasswordVisible,
          controller: widget.controller,
          decoration: InputDecoration(
            suffix: IconButton(
                splashRadius: 12,
                iconSize: 18,
                icon: Icon(
                  isPasswordVisible == true
                      ? Icons.visibility_off
                      : Icons.remove_red_eye,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                }),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            errorText: isPasswordValidate == false
                ? "Password must be at least 8 characters"
                : null,
            hintText: widget.hintText,
          )),
    );
  }
}
