import 'package:client/services/constants.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String description;
  final String name;
  final String user_id;

  const ProfileInfo(
      {Key? key,
      required this.description,
      required this.name,
      required this.user_id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              child: Text(description),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/avatar.jpg"),
              radius: 70,
            ),
            const SizedBox(height: 15),
            Text(name),
            Text(
              "id: $user_id",
              style: const TextStyle(color: kGrey),
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
