import 'package:client/models/author_model.dart';
import 'package:client/models/comment_model.dart';
import 'package:client/models/meme_model.dart';
import 'package:client/pages/profile_page.dart';
import 'package:client/services/constants.dart';
import 'package:client/services/server_service.dart';
import 'package:client/widgets/components/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class MemeCard extends StatefulWidget {
  final MemeModel meme;
  const MemeCard({Key? key, required this.meme}) : super(key: key);

  @override
  State<MemeCard> createState() => _MemeCardState();
}

class _MemeCardState extends State<MemeCard> {
  @override
  Widget build(BuildContext context) {
    final meme = widget.meme;
    return Column(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.all(20),
            child: Card(
              child: ListTile(
                onTap: () => {
                  Navigator.of(context).pushNamed(
                    ProfilePage.route,
                    arguments: ProfilePageArguments(id: meme.author.id),
                  )
                },
                title: Text(meme.author.userName),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.jpg"),
                ),
                trailing: IconButton(
                  padding: const EdgeInsets.all(5),
                  iconSize: 20,
                  icon: Icon(meme.author.isFollowed ? Icons.check : Icons.add),
                  color: kButtonColor,
                  onPressed: () {
                    setState(() {
                      meme.author.isFollowed = !meme.author.isFollowed;
                    });
                  },
                ),
              ),
            )),
        Expanded(
          child: GestureDetector(
            // handle swipe down
            onVerticalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity! < 0) {
                _showComments(meme);
              }
            },

            child: Image.asset(
              meme.url,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            iconSize: 40,
            onPressed: () {
              setState(() {
                meme.author.isLiked = !meme.author.isLiked;
              });
            },
            icon: Icon(Icons.favorite,
                color: meme.author.isLiked == true ? Colors.red : kButtonColor),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
              onPressed: () {
                _showComments(meme);
              },
              icon: const Icon(Icons.keyboard_arrow_down_rounded)),
        ),
      ],
    );
  }

  void _showComments(MemeModel meme) {
    final comments = <CommentModel>[];
    TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.keyboard_arrow_up_rounded)),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: comments.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Comment(
                        comment: comments[index],
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "Add comment",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: kButtonColor,
                        ),
                        onPressed: () async {
                          const storage = FlutterSecureStorage();
                          final user = await ServerService.getUser(
                              id: await storage.read(key: kId) ?? "");
                          setState(() {
                            comments.add(CommentModel(
                                author: AuthorModel(
                                    id: user.id ?? "",
                                    userName: user.userName,
                                    avatar: user.avatar,
                                    userId: user.userId),
                                id: "",
                                text: controller.text,
                                date: DateFormat('yyyy-MM-dd HH-ss')
                                    .format(DateTime.now())));
                            controller.text = "";
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
