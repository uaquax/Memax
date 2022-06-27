import 'package:client/models/author.dart';
import 'package:client/models/comment.dart';
import 'package:client/models/meme.dart';
import 'package:client/pages/memes/widgets/comment.dart';
import 'package:client/pages/profile/profile_page.dart';
import 'package:client/services/api.dart';
import 'package:client/services/colors.dart';
import 'package:client/services/storage_manager.dart';
import 'package:flutter/material.dart';

class MemeCard extends StatefulWidget {
  Meme meme;

  MemeCard({Key? key, required this.meme}) : super(key: key);

  @override
  State<MemeCard> createState() => _MemeCardState();
}

class _MemeCardState extends State<MemeCard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        child: ListTile(
          onTap: () => {_showProfile(widget.meme)},
          title: Text(widget.meme.author.userName),
          leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.meme.author.avatar)),
          trailing: IconButton(
            padding: const EdgeInsets.all(5),
            iconSize: 20,
            icon: Icon(widget.meme.author.isFollowed ? Icons.check : Icons.add),
            color: buttonColor,
            onPressed: () {
              setState(() {
                widget.meme.author.isFollowed = !widget.meme.author.isFollowed;
              });
            },
          ),
        ),
      ),
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  filterQuality: FilterQuality.high,
                  image: NetworkImage(widget.meme.picture),
                  fit: BoxFit.contain,
                ),
              ),
              child: Column(children: [
                Text(
                  widget.meme.title,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 15,
                        color: Colors.black,
                      ),
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: () {
                      _likeMeme(widget.meme);
                    },
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        _showComments(widget.meme);
                      }
                      if (details.primaryVelocity! > 0) {
                        _showProfile(widget.meme);
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(widget.meme.likesCount.toString()),
                      IconButton(
                        splashRadius: 5,
                        iconSize: 40,
                        onPressed: () {
                          setState(() {
                            _likeMeme(widget.meme);
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: widget.meme.isLiked == true
                              ? Colors.red
                              : buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    child: Text(
                      widget.meme.description,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                      onPressed: () {
                        _showComments(widget.meme);
                      },
                      icon: const Icon(Icons.keyboard_arrow_down_rounded)),
                ),
              ])))
    ]);
  }

  void _likeMeme(Meme meme) {
    setState(() {
      if (meme.isLiked == true) {
        meme.likesCount--;
      } else {
        meme.likesCount++;
      }
      meme.isLiked = !meme.isLiked;
    });

    API.changeLikeStatus(meme.id);
  }

  void _showProfile(Meme meme) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProfilePage(id: meme.author.id);
        });
  }

  void _showComments(Meme meme) {
    final comments = meme.comments;
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
                    physics: const BouncingScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CommentWidget(
                        commentId: comments[index],
                        onClick: () async {
                          final comment =
                              await API.getComment(id: comments[index]);
                          showGeneralDialog(
                              context: context,
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return ProfilePage(
                                    id: comment?.author.id ?? "");
                              });
                        },
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
                          API.createComment(
                              body: _controller.text, fatherId: meme.id);

                          final author = await API.getUser(
                              id: await StorageManager.getId());
                          setState(() {
                            comments.add(
                              Comment(
                                  author: Author(
                                      id: author?["user"]["id"],
                                      userName: author?["user"]["username"]),
                                  body: _controller.text),
                            );
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
