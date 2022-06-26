import 'package:client/services/config.dart';
import 'package:client/services/api.dart';
import 'package:client/services/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfileInfo extends StatefulWidget {
  final String id;
  final bool isOwner;

  const ProfileInfo({Key? key, required this.id, this.isOwner = false})
      : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  String? userName;
  String? biography;
  String avatar = "$apiUrl/default.jpg";
  String? userId;

  bool isLoading = true;
  bool isFollowed = false;

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  void _getInfo() async {
    final response = await API.getUser(id: widget.id);

    userId = response?["user_id"];
    userName = response?["username"];
    biography = response?["biography"];
    avatar = response?["avatar"];

    if (userName?.isEmpty == false) {
      setStateIfMounted(() => isLoading = false);
    }
  }

  void setStateIfMounted(func) {
    if (mounted) setState(func);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
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
                      child: Text(
                          widget.isOwner ? "Редактировать" : "Подписаться")),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ],
          );
  }
}
