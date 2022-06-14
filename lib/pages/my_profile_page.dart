import 'package:client/pages/create_meme_page.dart';
import 'package:client/services/constants.dart';
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
  String id = "";
  @override
  void initState() {
    super.initState();

    _getId();
  }

  void _getId() async {
    id = await StorageManager.getId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        const ProfileHeader(),
        ProfileInfo(id: id),
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
          style: TextStyle(color: kGrey, fontSize: 16),
        )
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(CreateMemePage.route);
          },
          backgroundColor: kButtonColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
