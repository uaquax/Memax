import 'package:client/widgets/memes/memes_header.dart';
import 'package:client/widgets/memes/memes_slider.dart';
import 'package:flutter/material.dart';

class MemesPage extends StatefulWidget {
  static const String route = "/memes";
  const MemesPage({Key? key}) : super(key: key);

  @override
  State<MemesPage> createState() => _MemesPageState();
}

class _MemesPageState extends State<MemesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const <Widget>[MemesHeader(), MemesSlider()],
      ),
    );
  }
}
