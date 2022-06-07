import 'package:client/services/constants.dart';
import 'package:client/widgets/profile/profile_header.dart';
import 'package:client/widgets/profile/profile_info.dart';
import 'package:flutter/material.dart';

class ProfilePageArguments {
  final String id;

  ProfilePageArguments({required this.id});
}

class ProfilePage extends StatefulWidget {
  static const String route = "/profile";

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
