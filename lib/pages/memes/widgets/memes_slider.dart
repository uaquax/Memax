import 'package:client/models/meme.dart';
import 'package:client/services/api.dart';
import 'package:client/pages/memes/widgets/meme_card.dart';
import 'package:flutter/material.dart';

class MemesSlider extends StatefulWidget {
  const MemesSlider({Key? key}) : super(key: key);

  @override
  State<MemesSlider> createState() => _MemesSliderState();
}

class _MemesSliderState extends State<MemesSlider> {
  static final List<Meme> _memes = <Meme>[];

  final int _limit = 3;
  bool isLoading = false;
  final PageController _pageController = PageController();
  int _page = 0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(
      () {
        if (_pageController.position.pixels ==
            _pageController.position.maxScrollExtent) {
          _addMemes();
        }
      },
    );

    _addMemes();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: _memes.length,
        itemBuilder: ((context, index) {
          if (index < _memes.length) {
            final meme = _memes[index];

            return MemeCard(meme: meme);
          }
          return Container();
        }),
      ),
    );
  }

  void _addMemes() async {
    if (!isLoading) {
      isLoading = true;

      final memes = await API.getMemes(page: _page, limit: _limit);

      if (memes?.isEmpty == false && memes != null) {
        if (!mounted) return;

        setState(() {
          _memes.addAll(memes);
        });
      }
      _page++;
      isLoading = false;
    }
  }
}
