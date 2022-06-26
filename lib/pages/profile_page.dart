import 'package:client/pages/create_meme_page.dart';
import 'package:client/services/config.dart';
import 'package:client/widgets/profile/profile_info.dart';
import 'package:client/widgets/profile/profile_memes.dart';
import 'package:flutter/material.dart';

class ProfilePageArguments {
  final String id;

  ProfilePageArguments({required this.id});
}

class ProfilePage extends StatefulWidget {
  static const String route = "/profile";
  final String id;
  final bool isOwner;

  const ProfilePage({Key? key, required this.id, this.isOwner = false})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          ProfileInfo(
            id: widget.id,
            isOwner: widget.isOwner,
          ),
          const SizedBox(height: 20),
          Container(
            height: 1.4,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 15),
          ProfileMemes(id: widget.id),
        ],
      ),
      floatingActionButton: widget.isOwner
          ? FloatingActionButton(
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const CreateMemePage();
                  },
                );
              },
              backgroundColor: buttonColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ))
          : null,
    );
  }
}
