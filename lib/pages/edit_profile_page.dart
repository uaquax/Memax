import 'package:client/models/user_model.dart';
import 'package:client/services/config.dart';
import 'package:client/widgets/profile/profile_header.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  static const String route = "/edit_profile";
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as EditProfileArguments;

    return Scaffold(
      body: Column(children: <Widget>[
        const ProfileHeader(),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    args.user.biography.isEmpty == true
                        ? "Нет описания"
                        : args.user.biography,
                    style: TextStyle(
                        color: args.user.biography.isEmpty == true
                            ? grey
                            : Colors.black),
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(args.user.avatar),
                  radius: 70,
                  child: IconButton(
                      icon: const Icon(Icons.edit), onPressed: () {}),
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(hintText: args.user.userName),
                ),
                Text(
                  "id: $widget.user.userId",
                  style: const TextStyle(color: grey),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            )
          ],
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
          style: TextStyle(color: grey, fontSize: 16),
        )
      ]),
    );
  }
}

class EditProfileArguments {
  final UserModel user;

  const EditProfileArguments({required this.user});
}
