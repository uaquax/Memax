import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:client/models/author_model.dart';
import 'package:client/models/meme_model.dart';
import 'package:client/services/constants.dart';
import 'package:client/widgets/memes/memes_header.dart';
import 'package:flutter/material.dart';

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
      author: AuthorModel(userName: "uaquax"),
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
                              child: Image.asset(
                                meme.url,
                                fit: BoxFit.contain,
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
                                  onPressed: () {},
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
        author: AuthorModel(userName: "uaquax"),
        description: 'What is meme?',
        id: '1',
        type: MemeType.image,
      ));
    });
  }
}
