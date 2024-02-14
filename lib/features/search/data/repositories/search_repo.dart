import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/common/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class SearchRepository {
  getUserList({
    required String? gender,
    required int? maxAge,
    required int? minAge,
    required int? cityId,
    required int page,
  }) async {
    final dio = Dio();
    final url = mainUrl;
    var storage = await _storage;
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    String finalUrl;
    finalUrl = '${url}v2/profile/list/?page=$page';
    try {
      final response = await dio.get(finalUrl);
      if (kDebugMode) {
        print(response.data);
      }
      List data = response.data['results'];
      if (response.statusCode == 200) {
        return data;
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
