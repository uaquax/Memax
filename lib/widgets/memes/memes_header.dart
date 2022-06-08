import 'package:client/pages/profile_page.dart';
import 'package:client/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
                const storage = FlutterSecureStorage();
                final String? id = await storage.read(key: kId);

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
