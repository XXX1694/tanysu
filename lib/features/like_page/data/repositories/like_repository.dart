import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';
import 'package:tanysu/features/like_page/data/models/like_person.dart';

final _storage = SharedPreferences.getInstance();

class LikeRepository {
  likesMe() async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}profile/likes-me/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    try {
      final response = await dio.get(
        finalUrl,
      );
      List data = response.data;
      List<LikePersonModel> result = [];
      if (response.statusCode == 200) {
        for (int i = 0; i < data.length; i++) {
          final user = LikePersonModel.fromJson(data[i]);
          result.add(user);
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  meLike() async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}profile/my-likes/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";

    try {
      final response = await dio.get(
        finalUrl,
      );
      List data = response.data;
      List<LikePersonModel> result = [];
      if (response.statusCode == 200) {
        for (int i = 0; i < data.length; i++) {
          final user = LikePersonModel.fromJson(data[i]);
          result.add(user);
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
