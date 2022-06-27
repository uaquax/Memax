import 'package:client/models/author.dart';

class Comment {
  String id;
  Author author;
  String body;
  List comments;
  String fatherId;

  Comment({
    required this.author,
    required this.body,
    this.id = "",
    this.fatherId = "",
    this.comments = const [],
  });
}
