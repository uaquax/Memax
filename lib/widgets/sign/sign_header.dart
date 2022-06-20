import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignHeader extends StatelessWidget {
  const SignHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.all(0),
      child: SvgPicture.asset('assets/images/sign.svg', width: 220),
    ));
  }
}
