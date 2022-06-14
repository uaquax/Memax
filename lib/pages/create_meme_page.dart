import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:client/pages/memes_page.dart';
import 'package:client/services/colors.dart';
import 'package:client/services/server_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CreateMemePage extends StatefulWidget {
  static const String route = "/create_meme";
  const CreateMemePage({Key? key}) : super(key: key);

  @override
  State<CreateMemePage> createState() => _CreateMemePageState();
}

class _CreateMemePageState extends State<CreateMemePage> {
  File? _image;

  var sampleImage;

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
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            final meme = getBytesFromImage(_image ?? File(""));
            ServerService.createMeme(meme);

            Navigator.of(context).pushNamed(MemesPage.route);
          },
          backgroundColor: kButtonColor,
          child: const Icon(
            Icons.publish,
            color: Colors.white,
          )),
    );
  }

  getBytesFromImage(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    return imageBytes;
  }
}
