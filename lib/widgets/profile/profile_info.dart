import 'package:client/services/colors.dart';
import 'package:client/services/constants.dart';
import 'package:client/services/server_service.dart';
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

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  void _getInfo() async {
    final user = await ServerService.getUser(id: widget.id);
    setState(() {
      description = user.biography;
      userName = user.userName;
      biography = user.biography.isEmpty ? "" : user.biography;
      avatar = user.avatar;
      userId = user.userId;

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: SpinKitCircle(size: 120, color: kGrey),
          )
        : Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
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
                              ? kGrey
                              : Colors.black),
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(avatar),
                    radius: 70,
                  ),
                  const SizedBox(height: 15),
                  Text(userName ?? "Нет имени"),
                  Text(
                    "id: $userId",
                    style: const TextStyle(color: kGrey),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              )
            ],
          );
  }
}
