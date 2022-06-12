import 'dart:io';

import 'package:client/pages/memes_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateMemePage extends StatefulWidget {
  static const String route = "/create_meme";
  const CreateMemePage({Key? key}) : super(key: key);

  @override
  State<CreateMemePage> createState() => _CreateMemePageState();
}

class _CreateMemePageState extends State<CreateMemePage> {
  File? _image;

  @override
  void initState() {
    super.initState();

    _getImage();
  }

  void _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image?.path ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.file(_image ?? File("")),
          // Create text fields with margin
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Enter meme title here",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Create The textfield with height 200
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Enter meme description here",
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Create a button with margin
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(MemesPage.route);
          },
          child: const Icon(Icons.publish)),
    );
  }
}
