import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/common/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class SearchRepository {
  getUserList(
    String? gender,
    int? maxAge,
    int? cityId,
  ) async {
    final dio = Dio();
    final url = mainUrl;
    var storage = await _storage;
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    String finalUrl;
    if (gender == null && maxAge == null && cityId == null) {
      finalUrl = '${url}profile/list/';
    } else {
      finalUrl =
          '${url}profile/list/?min_age=18&max_age=$maxAge&city=$cityId&gender=$gender';
    }

    Uri? uri = Uri.tryParse(finalUrl);
    if (uri != null) {
      try {
        final response = await dio.get(finalUrl);
        if (kDebugMode) {
          print(response.data);
        }
        List data = response.data;
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
}
