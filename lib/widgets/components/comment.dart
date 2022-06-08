import 'package:client/models/comment_model.dart';
import 'package:client/models/meme_model.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  CommentModel comment;

  Comment({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/images/avatar.jpg"),
          radius: 25,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.author.userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(comment.text),
            ),
          ],
        ),
      ]),
    );
  }
}
