import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:tanysu/core/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class GetUserIdRepo {
  getUserId() async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}users/get-id/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    try {
      final response = await dio.get(finalUrl);

      if (response.statusCode == 200) {
        int data = response.data['user_id'];
        storage.setInt('user_id', data);
        return response.data['user_id'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

like({required int userId}) async {
  final storage = await _storage;
  final url = mainUrl;
  String finalUrl = '${url}like/$userId/';
  final dio = Dio();
  String? token = storage.getString('auth_token');
  if (token == null) return null;
  dio.options.headers["authorization"] = "Token $token";
  await dio.post(finalUrl);
}
