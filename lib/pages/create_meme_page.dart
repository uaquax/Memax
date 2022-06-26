import 'dart:io';

import 'package:client/models/author_model.dart';
import 'package:client/models/meme_model.dart';
import 'package:client/pages/memes_page.dart';
import 'package:client/services/colors.dart';
import 'package:client/services/api.dart';
import 'package:client/services/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateMemePage extends StatefulWidget {
  static const String route = "/create_meme";
  const CreateMemePage({Key? key}) : super(key: key);

  @override
  State<CreateMemePage> createState() => _CreateMemePageState();
}

class _CreateMemePageState extends State<CreateMemePage> {
  XFile? _image;
  File? _file;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _getImage();
  }

  void _getImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        _file = File(image!.path);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.file(
            _file ?? File(""),
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Enter meme title here",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: "Enter meme description here",
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            final MemeModel meme = MemeModel(
              type: MemeType.image,
              title: _titleController.text,
              description: _descriptionController.text,
              file: _image,
            );

            API.createMeme(meme: meme);

            Navigator.of(context).pop();
            Navigator.of(context).pop();
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
