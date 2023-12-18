import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/common/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class GetGiftRepository {
  getGifts() async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}gift/list/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    Uri? uri = Uri.tryParse(finalUrl);
    if (kDebugMode) {
      print(token);
      print(uri);
    }
    if (uri != null) {
      try {
        final response = await dio.get(finalUrl);
        List<dynamic> data = response.data;
        if (kDebugMode) {
          print(response.data);
        }
        if (response.statusCode == 200) {
          return data;
        } else {
          return null;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}
