import 'package:client/services/constants.dart';
import 'package:client/widgets/profile/profile_header.dart';
import 'package:client/widgets/profile/profile_info.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static const String route = "/profile";
  final int id;
  const ProfilePage({Key? key, this.id = 0}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        const ProfileHeader(),
        const ProfileInfo(
          description:
              'Я крутой блогер Йоу. Подпишись на мой телеграмм канал: t.me/fsfsdfsdfsd',
          name: 'Даня Милохин',
          user_id: 'danya_milohin',
        ),
        const SizedBox(height: 20),
        Container(
          height: 1,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "У данного пользователя пока нет мемов",
          style: TextStyle(color: kGrey, fontSize: 16),
        )
      ]),
    );
  }
}
