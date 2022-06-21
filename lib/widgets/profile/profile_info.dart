import 'package:client/services/config.dart';
import 'package:client/services/server_service.dart';
import 'package:client/services/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfileInfo extends StatefulWidget {
  final String id;

  const ProfileInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  String? userName;
  String? biography;
  String avatar = defaultAvatarUrl;
  String? userId;

  bool isLoading = true;
  bool isOwner = false;
  bool isFollowed = false;

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  void _getInfo() async {
    final user = await ServerService.getUser(id: widget.id);

    print(userName?.isEmpty);

    userName = user["username"];
    biography = user["biography"];
    avatar = user["avatar"];

    print(userName?.isEmpty);

    if (userName?.isEmpty == false) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: SpinKitCircle(size: 120, color: grey),
          )
        : Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      biography == null || biography?.isEmpty == true
                          ? "Нет описания"
                          : biography ?? "Нет описания",
                      style: TextStyle(
                          color: biography == null || biography?.isEmpty == true
                              ? grey
                              : Colors.white),
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/avatar.jpg"),
                  ),
                  const SizedBox(height: 15),
                  Text(userName ?? ""),
                  Text(
                    "id: $userId",
                    style: const TextStyle(color: grey),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(isOwner ? "Редактировать" : "Подписаться")),
                ],
              ),
              const SizedBox(
                width: 20,
              )
            ],
          );
  }
}
