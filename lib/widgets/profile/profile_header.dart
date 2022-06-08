import 'package:client/pages/memes_page.dart';
import 'package:client/pages/settings_page.dart';
import 'package:client/services/colors.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(MemesPage.route);
              },
              icon: const Icon(
                Icons.home,
                color: kGrey,
              ),
              iconSize: 35,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SettingsPage.route);
              },
              icon: const Icon(
                Icons.settings,
                color: kGrey,
              ),
              //make icon bigger
              iconSize: 35,
            ),
          ],
        ),
      ],
    );
  }
}
