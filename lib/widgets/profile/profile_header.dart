import 'package:client/pages/memes_page.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(MemesPage.route);
              },
              icon: const Icon(Icons.home),
              iconSize: 35,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              //make icon bigger
              iconSize: 35,
            ),
          ],
        ),
      ],
    );
  }
}
