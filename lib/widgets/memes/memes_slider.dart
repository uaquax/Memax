import 'package:client/models/author_model.dart';
import 'package:client/models/comment_model.dart';
import 'package:client/pages/profile_page.dart';
import 'package:client/services/config.dart';
import 'package:client/services/api.dart';
import 'package:client/services/storage_manager.dart';
import 'package:client/widgets/components/comment.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../models/meme_model.dart';

class MemesSlider extends StatefulWidget {
  const MemesSlider({Key? key}) : super(key: key);

  @override
  State<MemesSlider> createState() => _MemesSliderState();
}

class _MemesSliderState extends State<MemesSlider> {
  static final List<MemeModel> _memes = <MemeModel>[];

  final int _limit = 2;
  final PageController _pageController = PageController();
  int _lastIndex = 0;

  @override
  void initState() {
    _addMemes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: _pageChanged,
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.down,
        children: _memes.map((meme) {
          return Column(
            children: [
              Card(
                child: ListTile(
                  onTap: () => {_showProfile(meme)},
                  title: Text(meme.author!.userName),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(meme.author!.avatar)),
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
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      filterQuality: FilterQuality.high,
                      image: NetworkImage(meme.picture ?? ""),
                      fit: BoxFit.contain,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 10.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(children: [
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
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(meme.likesCount.toString()),
                          IconButton(
                            splashRadius: 5,
                            iconSize: 40,
                            onPressed: () {
                              setState(() {
                                _likeMeme(meme);
                              });
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: meme.isLiked == true
                                  ? Colors.red
                                  : buttonColor,
                            ),
                          ),
                        ],
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
                  ]),
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }

  void _pageChanged(int index) async {
    if (index == _memes.length - 1) {
      await Future.delayed(const Duration(seconds: 0))
          .then((value) => {_addMemes()});
    }
  }

  void _likeMeme(MemeModel meme) {
    setState(() {
      if (meme.isLiked == true) {
        meme.likesCount--;
      } else {
        meme.likesCount++;
      }
      meme.isLiked = !meme.isLiked;
    });

    API.changeLikeStatus(meme.id ?? "");
  }

  void _showProfile(MemeModel meme) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProfilePage(id: meme.author!.id);
        });
  }

  void _showComments(MemeModel meme) {
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
                    reverse: true,
                    itemCount: comments.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Comment(
                        comment: CommentModel(
                            author: comments[index].author,
                            text: comments[index].text,
                            date: comments[index].date),
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
                          setState(() {
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

  void _addMemes() async {
    final memes = await API.getMemes(limit: _limit, page: _memes.length);
    if (memes != null && memes.length > 0) {
      try {
        for (final meme in memes["posts"]) {
          final author = await API.getUser(id: meme["author"]);
          _memes.add(
            MemeModel(
              type: MemeType.image,
              author: AuthorModel(
                  id: author?["id"],
                  userName: author?["username"],
                  avatar: author?["avatar"]),
              picture: meme["picture"],
              id: meme["id"] ?? "",
              description: meme["description"],
              title: meme["title"],
              likes: meme["likes"],
              comments: meme["comments"],
            ),
          );
          _memes.last.isLiked =
              _memes.last.likes.contains(await StorageManager.getId());
          _memes.last.likesCount = _memes.last.likes.length;
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(e.toString()),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }

    setState(() {});
  }
}
