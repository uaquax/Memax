import 'package:client/models/author_model.dart';

class CommentModel {
  AuthorModel author;
  String id;
  String text;
  String date;

  CommentModel({
    required this.author,
    required this.id,
    required this.text,
    required this.date,
  });
}
