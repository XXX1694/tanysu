import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';

final _storage = SharedPreferences.getInstance();

class ProfilePreviewRepository {
  getUser({required userId}) async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}profile/detail/$userId/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    try {
      final response = await dio.get(
        finalUrl,
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
