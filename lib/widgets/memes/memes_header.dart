import 'package:client/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MemesHeader extends StatelessWidget {
  const MemesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ProfilePage.route);
              },
              icon: const Icon(Icons.menu)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
    ]);
  }
}
