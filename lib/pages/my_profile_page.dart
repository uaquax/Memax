import 'package:client/pages/create_meme_page.dart';
import 'package:client/pages/profile_page.dart';
import 'package:client/services/config.dart';
import 'package:client/services/storage_manager.dart';
import 'package:client/widgets/profile/profile_header.dart';
import 'package:client/widgets/profile/profile_info.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  static const String route = "/my_profile";

  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as ProfilePageArguments;
    return Scaffold(
      body: Column(children: <Widget>[
        const ProfileHeader(),
        ProfileInfo(id: args.id),
        const SizedBox(height: 20),
        Container(
          height: 1.4,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "У данного пользователя пока нет мемов",
          style: TextStyle(color: grey, fontSize: 16),
        )
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(CreateMemePage.route);
          },
          backgroundColor: buttonColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
