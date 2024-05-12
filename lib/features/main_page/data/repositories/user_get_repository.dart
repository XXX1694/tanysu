import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:tanysu/core/constants/constants.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';

final _storage = SharedPreferences.getInstance();

class UserGetRepository {
  getRandomUsers() async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}profile/suggest/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";

    try {
      final response = await dio.get(finalUrl);

      if (response.statusCode == 200) {
        List data = response.data;
        List<ProfileModel> result = [];
        for (int i = 0; i < data.length; i++) {
          final user = ProfileModel.fromJson(data[i]);

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

  like({required int profileId}) async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}like/$profileId/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";

    await dio.post(finalUrl);
  }

  dislike({required int profileId}) async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}like/dislike/$profileId/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    await dio.post(finalUrl);
  }

  unlike({required int profileId}) async {
    final storage = await _storage;
    final url = mainUrl;

    String finalUrl = '${url}like/unlike/$profileId/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";

    await dio.post(finalUrl);
  }
}
