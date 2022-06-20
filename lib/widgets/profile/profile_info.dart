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
  String? description;

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
    isOwner = user.userId == await StorageManager.getId();

    description = user.biography;
    userName = user.userName;
    biography = user.biography.isEmpty ? "" : user.biography;
    avatar = user.avatar;
    userId = user.userId;

    if (user.userName != "") {
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
                      description == null || description?.isEmpty == true
                          ? "Нет описания"
                          : description ?? "Нет описания",
                      style: TextStyle(
                          color: description == null ||
                                  description?.isEmpty == true
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
                  const Text("uaquax"),
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
