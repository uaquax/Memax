import 'dart:convert';
import 'package:client/models/auth_model.dart';
import 'package:client/models/author.dart';
import 'package:client/models/comment.dart';
import 'package:client/models/meme.dart';
import 'package:client/services/storage_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['API_URL'] ?? 'http://localhost:3000',
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          final token = await StorageManager.getJWT();
          if (token.isEmpty == false) {
            request.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(request);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final token = await StorageManager.getJWT();
            if (token.isNotEmpty) {
              await refreshToken();

              return handler.resolve(await _retry(error.requestOptions));
            }
          }
          return handler.next(error);
        },
      ),
    );

  static Future<Map?> getUser({required String id}) async {
    final response = await _dio.get("/user/$id");

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      return response.data;
    }
    return null;
  }

  static Future<Comment?> getComment({required String id}) async {
    final Response response = await _dio.get("/comment/$id");

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      final author = await getUser(id: response.data["author"]);
      return Comment(
        id: response.data['id'],
        body: response.data['body'],
        fatherId: response.data["fatherId"] ?? "",
        author: Author(id: author?["id"], userName: author?["username"]),
      );
    }
    return null;
  }

  static Future<Map?> signUp({required AuthModel user}) async {
    try {
      FormData data = FormData.fromMap(
        {
          'email': user.email,
          'username': user.userName,
          'password': user.password,
        },
      );
      final response = await _dio.post("/sign-up", data: data);

      if (response.statusCode == 200) {
        StorageManager.saveRefreshToken(response.data["refreshToken"]);
        StorageManager.saveJWT(response.data["accessToken"]);
        StorageManager.saveId(response.data["user"]["id"]);

        return response.data;
      } else {
        throw Exception(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  static Future<Map?> signIn({required AuthModel user}) async {
    final response = await _dio.post("/sign-in",
        data: jsonEncode({
          "email": user.email,
          "password": user.password,
        }));

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      StorageManager.saveRefreshToken(response.data["refreshToken"]);
      StorageManager.saveJWT(response.data["accessToken"]);
      StorageManager.saveId(response.data["user"]["id"]);

      return response.data;
    }
    return null;
  }

  static void createComment(
      {required String body, required String fatherId}) async {
    await _dio.post(
      "/create-comment",
      data: jsonEncode(
        {
          "body": body,
          "fatherId": fatherId,
        },
      ),
    );
  }

  static createMeme({required Meme meme}) async {
    FormData formData = FormData.fromMap({
      "title": meme.title,
      "description": meme.description,
    });
    formData.files.add(
      MapEntry(
        "picture",
        await MultipartFile.fromFile(meme.file!.path,
            filename: meme.file?.path.split("/").last),
      ),
    );
    final Response response = await _dio.post("/create-post", data: formData);

    if (response.statusCode == 200) {
      return response.data;
    }
  }

  static Future<List<Meme>?> getMemes(
      {required int page, required int limit}) async {
    final Response response = await _dio.get("/posts?page=$page&limit=$limit");

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      final responseMemes = response.data["posts"];

      if (responseMemes.isNotEmpty) {
        final List<Meme> memes = [];
        for (var meme in responseMemes) {
          if (kDebugMode) {
            print("$meme \n\n");
          }
          final author = await API.getUser(id: meme["author"]);

          memes.add(
            Meme(
              author: Author(
                  id: author?["id"],
                  userName: author?["username"],
                  avatar: author?["avatar"]),
              picture: meme?["picture"],
              id: meme?["id"] ?? "",
              description: meme?["description"],
              title: meme?["title"],
              likes: meme?["likes"],
              comments: meme?["comments"],
            ),
          );

          memes.last.isLiked =
              memes.last.likes.contains(await StorageManager.getId());
          memes.last.likesCount = memes.last.likes.length;
        }
        return memes;
      }
    }
  }

  static Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }

  static refreshToken() async {
    final token = await StorageManager.getRefreshToken();

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_URL'] ?? 'http://localhost:3000',
      ),
    );

    if (token.isNotEmpty) {
      final Response response = await dio.post(
        "/refresh/mobile",
        data: jsonEncode({
          "refreshToken": token,
        }),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 && response.data.isNotEmpty) {
        StorageManager.saveJWT(response.data["accessToken"]);
        StorageManager.saveRefreshToken(response.data["refreshToken"]);

        await Future.delayed(const Duration(seconds: 0)).then(
          (value) {
            return response.data;
          },
        );
      } else {
        StorageManager.clear();
      }
    }
  }

  static Future<Map?> changeLikeStatus(String memeId) async {
    final Response response = await _dio.post("/change-like-status", data: {
      "id": memeId,
    });

    if (response.statusCode == 401 || response.statusCode == 403) {
      print("\n\n  <- Error -> 401~~ \n\n");
    }

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      return response.data;
    }
    return null;
  }

  static Future<Map?> getUserMemes(
      {required String id, required int limit}) async {
    final Response response =
        await _dio.get("/posts/user/$id?limit=$limit&page=1");

    if (response.statusCode == 401 || response.statusCode == 403) {
      print("\n\n  <- Error -> 401~~ \n\n");
    }

    if (response.statusCode == 200 && response.data.isNotEmpty) {
      return response.data;
    }
    return null;
  }
}
