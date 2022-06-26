import 'package:client/pages/profile_page.dart';
import 'package:client/pages/settings_page.dart';
import 'package:client/pages/sign_up_page.dart';
import 'package:client/services/config.dart';
import 'package:client/services/storage_manager.dart';
import 'package:client/widgets/memes/memes_slider.dart';
import 'package:flutter/material.dart';

class MemesPage extends StatefulWidget {
  static const String route = "/memes";
  const MemesPage({Key? key}) : super(key: key);

  @override
  State<MemesPage> createState() => _MemesPageState();
}

class _MemesPageState extends State<MemesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: drawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              splashRadius: 12,
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ),
        ),
        body: Column(
          children: const [MemesSlider()],
        ),
      );

  Widget drawer() {
    return Drawer(
      backgroundColor: backgroundColor,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Profile"),
            onTap: () async {
              final id = await StorageManager.getId();

              showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return ProfilePage(
                      id: id,
                      isOwner: true,
                    );
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text("Refresh"),
            onTap: () async {
              final refreshToken = await StorageManager.getRefreshToken();
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("Refresh token"),
                        content: Text(refreshToken),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
            },
          ),
          const Spacer(),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {
                  Navigator.of(context).pushNamed(SettingsPage.route);
                },
              ),
              const Divider(
                thickness: 2,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ListTile(
                  textColor: Colors.red,
                  iconColor: Colors.red,
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text("Log Out"),
                  onTap: () async {
                    StorageManager.clear();

                    if (!mounted) return;
                    Navigator.of(context).pushNamed(SignUpPage.route);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
