import 'package:client/models/comment.dart';
import 'package:client/services/api.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  String commentId;
  final Function onClick;

  CommentWidget({Key? key, required this.commentId, required this.onClick})
      : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  Comment? comment;

  @override
  void initState() {
    super.initState();

    _getComment();
  }

  void _getComment() async {
    comment = await API.getComment(id: widget.commentId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClick();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(children: [
          CircleAvatar(
            backgroundImage: NetworkImage(comment?.author.avatar ?? ""),
            radius: 25,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment?.author.userName ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(comment?.body ?? ""),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
