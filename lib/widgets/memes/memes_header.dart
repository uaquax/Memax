import 'package:client/pages/profile_page.dart';
import 'package:client/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemesHeader extends StatelessWidget {
  const MemesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 50),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? id = prefs.getString(spId);

                Future.delayed(Duration.zero).then((_) {
                  Navigator.of(context).pushNamed(ProfilePage.route,
                      arguments: ProfilePageArguments(id: id ?? ""));
                });
              },
              icon: const Icon(Icons.menu)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
    ]);
  }
}
