import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignInput extends HookWidget {
  final String hintText;
  final bool isObscureText;
  final TextEditingController controller;
  final double topPadding;

  const SignInput(
      {Key? key,
      required this.hintText,
      this.topPadding = 10,
      required this.controller,
      this.isObscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPasswordValidate = useState(true);
    useEffect(() {
      if (controller.text.isEmpty) {
        isPasswordValidate.value = true;
      } else {
        isPasswordValidate.value = controller.text.length >= 8;
      }
      return null;
    }, const []);

    if (isObscureText == true) {
      return Container(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
        child: TextField(
            enableInteractiveSelection: true,
            autocorrect: false,
            enableSuggestions: false,
            toolbarOptions: const ToolbarOptions(
              copy: false,
              paste: false,
              cut: false,
              selectAll: false,
            ),
            obscureText: isObscureText,
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              errorText: isPasswordValidate.value == false
                  ? "Password must be at least 8 characters"
                  : null,
              hintText: hintText,
            )),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
        child: TextField(
            obscureText: isObscureText,
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            )),
      );
    }
  }

  String getText() => controller.text;

  String? validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return null;
  }
}
