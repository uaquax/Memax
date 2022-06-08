import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:client/models/author_model.dart';
import 'package:client/models/comment_model.dart';
import 'package:client/models/meme_model.dart';
import 'package:client/pages/profile_page.dart';
import 'package:client/services/constants.dart';
import 'package:client/services/server_service.dart';
import 'package:client/widgets/components/comment.dart';
import 'package:client/widgets/memes/memes_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class MemesPage extends StatefulWidget {
  static const String route = "/memes";
  const MemesPage({Key? key}) : super(key: key);

  @override
  State<MemesPage> createState() => _MemesPageState();
}

class _MemesPageState extends State<MemesPage> {
  final List<MemeModel> _memes = <MemeModel>[
    MemeModel(
      title: "Meme?",
      url: "assets/images/meme_1.jpg",
      author: AuthorModel(id: "", userName: "uaquax"),
      description: 'What is meme?',
      id: '1',
      type: MemeType.image,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const MemesHeader(),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
              ),
              items: _memes.map((MemeModel meme) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                  onTap: () => {
                                    Navigator.of(context).pushNamed(
                                      ProfilePage.route,
                                      arguments: ProfilePageArguments(
                                          id: meme.author.id),
                                    )
                                  },
                                  title: Text(meme.author.userName),
                                  leading: const CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/images/avatar.jpg"),
                                  ),
                                  trailing: IconButton(
                                    padding: const EdgeInsets.all(5),
                                    iconSize: 20,
                                    icon: Icon(meme.author.isFollowed
                                        ? Icons.check
                                        : Icons.add),
                                    color: kButtonColor,
                                    onPressed: () {
                                      setState(() {
                                        meme.author.isFollowed =
                                            !meme.author.isFollowed;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
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
                                    meme.isLiked = !meme.isLiked;
                                    _addMeme();
                                  });
                                },
                                icon: Icon(Icons.favorite,
                                    color: meme.isLiked == true
                                        ? Colors.red
                                        : kButtonColor),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: IconButton(
                                  onPressed: () {
                                    _showComments(meme);
                                  },
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
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

  void _addMeme() {
    final memeUrls = <String>[
      "assets/images/meme_1.jpg",
      "assets/images/meme_2.jpg",
      "assets/images/meme_3.jpg",
    ];

    setState(() {
      _memes.add(MemeModel(
        title: "Meme?",
        url: memeUrls[Random().nextInt(memeUrls.length)],
        author: AuthorModel(id: "", userName: "uaquax"),
        description: 'What is meme?',
        id: '1',
        type: MemeType.image,
      ));
    });
  }
}
