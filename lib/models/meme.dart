import 'package:client/models/author.dart';
import 'package:client/services/config.dart';
import 'package:image_picker/image_picker.dart';

class Meme {
  final String id;
  final String title;
  final String description;
  final String picture;
  final XFile? file;
  final Author author;
  final List comments;
  bool isLiked;
  List likes;
  int likesCount;

  Meme({
    required this.title,
    required this.description,
    this.file,
    this.likesCount = 0,
    String? picture,
    String? id,
    Author? author,
    List? comments,
    List? likes,
    bool? isLiked,
  })  : id = id ?? '',
        author = author ?? Author(id: "", userName: ""),
        comments = comments ?? [],
        likes = likes ?? [],
        picture = picture ?? "$SERVER_URL/default.jpg",
        isLiked = isLiked ?? false;
}
