import 'package:client/models/author_model.dart';
import 'package:image_picker/image_picker.dart';

class MemeModel {
  MemeType type;
  String? picture;
  String? id;
  AuthorModel? author;
  String title;
  String description;
  XFile? file;

  MemeModel({
    required this.type,
    required this.title,
    required this.description,
    this.picture,
    this.id,
    this.author,
    this.file,
  });
}

enum MemeType {
  image,
  video,
}
