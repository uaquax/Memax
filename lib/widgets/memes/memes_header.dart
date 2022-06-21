import 'package:client/pages/my_profile_page.dart';
import 'package:client/pages/profile_page.dart';
import 'package:client/services/storage_manager.dart';
import 'package:flutter/material.dart';

class MemesHeader extends StatelessWidget {
  const MemesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed(MyProfilePage.route,
                      arguments: ProfilePageArguments(
                          id: await StorageManager.getId()));
                },
                icon: const Icon(Icons.menu)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
      ],
    );
  }
}
