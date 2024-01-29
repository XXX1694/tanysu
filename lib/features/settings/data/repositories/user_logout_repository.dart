import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/common/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class UserLogOutRepository {
  logOut() async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}auth/token/logout/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    await dio.post(finalUrl);
    storage.remove('auth_token');
  }
}
