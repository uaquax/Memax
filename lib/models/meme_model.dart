import 'package:client/models/author_model.dart';

class MemeModel {
  MemeType type;
  String picture;
  String id;
  AuthorModel author;
  String title;
  String description;

  MemeModel({
    required this.type,
    required this.picture,
    required this.id,
    required this.author,
    required this.title,
    required this.description,
  });
}

enum MemeType {
  image,
  video,
}
