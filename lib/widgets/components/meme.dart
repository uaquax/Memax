import 'package:client/models/author_model.dart';
import 'package:client/models/comment_model.dart';
import 'package:client/models/meme_model.dart';
import 'package:client/pages/profile_page.dart';
import 'package:client/services/config.dart';
import 'package:client/services/server_service.dart';
import 'package:client/services/storage_manager.dart';
import 'package:client/widgets/components/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemeCard extends StatefulWidget {
  bool isLoading = false;
  _MemeCardState? memeCardState;
  final MemeModel meme;
  MemeCard({Key? key, required this.meme}) : super(key: key);

  @override
  State<MemeCard> createState() => _MemeCardState();
}

class _MemeCardState extends State<MemeCard> {
  @override
  void initState() {
    widget.memeCardState = this;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final meme = widget.meme;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 10.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Card(
                child: ListTile(
                  onTap: () => {_showProfile(meme)},
                  title: Text(meme.author!.userName),
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/avatar.jpg"),
                  ),
                  trailing: IconButton(
                    padding: const EdgeInsets.all(5),
                    iconSize: 20,
                    icon:
                        Icon(meme.author!.isFollowed ? Icons.check : Icons.add),
                    color: buttonColor,
                    onPressed: () {
                      setState(() {
                        meme.author!.isFollowed = !meme.author!.isFollowed;
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onDoubleTap: () {
                  _likeMeme(meme);
                },
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    _showComments(meme);
                  }
                  if (details.primaryVelocity! > 0) {
                    _showProfile(meme);
                  }
                },
                child: widget.isLoading || meme.picture!.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Image.network(meme.picture ?? "", fit: BoxFit.contain),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                iconSize: 40,
                onPressed: () {
                  setState(() {
                    _likeMeme(meme);
                  });
                },
                icon: Icon(Icons.favorite,
                    color: meme.author?.isLiked == true
                        ? Colors.red
                        : buttonColor),
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
        ),
      ),
    );
  }

  void setLoading(bool isLoading) {
    setState(() {
      widget.isLoading = isLoading;
    });
  }

  void _likeMeme(MemeModel meme) {
    setState(() {
      meme.author?.isLiked = !meme.author!.isLiked;
    });
  }

  void _showProfile(MemeModel meme) {
    Navigator.of(context).pushNamed(
      ProfilePage.route,
      arguments: ProfilePageArguments(id: meme.author!.id),
    );
  }

  void _showComments(MemeModel meme) {
    final comments = <CommentModel>[];
    TextEditingController _controller = TextEditingController();

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
                          controller: _controller,
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
                          color: buttonColor,
                        ),
                        onPressed: () async {
                          final user = await ServerService.getUser(
                              id: await StorageManager.getId());
                          setState(() {
                            comments.add(CommentModel(
                                author: AuthorModel(
                                    id: user.id ?? "",
                                    userName: user.userName,
                                    avatar: user.avatar,
                                    userId: user.userId),
                                id: "",
                                text: _controller.text,
                                date: DateFormat('yyyy-MM-dd HH-ss')
                                    .format(DateTime.now())));
                            _controller.text = "";
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
