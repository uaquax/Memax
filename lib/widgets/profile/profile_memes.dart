import 'package:client/services/config.dart';
import 'package:client/services/api.dart';
import 'package:flutter/material.dart';

class ProfileMemes extends StatefulWidget {
  final String id;

  const ProfileMemes({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfileMemes> createState() => _ProfileMemesState();
}

class _ProfileMemesState extends State<ProfileMemes> {
  bool isLoading = true;
  List? memes = [];

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  void _getInfo() async {
    final response = await API.getUserMemes(id: widget.id, limit: 3);
    memes = response?["posts"];

    setStateIfMounted(() => isLoading = false);
  }

  void setStateIfMounted(func) {
    if (mounted) {
      setState(() {
        func();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          )
        : memes!.isEmpty
            ? const Text(
                "У данного пользователя нет мемов",
                style: TextStyle(color: grey),
              )
            : Expanded(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  children: List.generate(memes!.length, (index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      child: Image.network(
                        memes![index]["picture"],
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                ),
              );
  }
}
