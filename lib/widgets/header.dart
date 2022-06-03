import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(0),
        child: Image.asset(
          "assets/images/security.png",
          width: 180,
        ),
      ),
    );
  }
}
