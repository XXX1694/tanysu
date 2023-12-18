import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/common/constants/constants.dart';
import 'package:tanysu/features/juz/data/models/juz_model.dart';

final _storage = SharedPreferences.getInstance();

class JuzRepository {
  juzGet() async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}juz/list/';
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
        // print(response.data);
        if (response.statusCode == 200) {
          List data = response.data;
          List<JuzModel> result = [];
          for (int i = 0; i < data.length; i++) {
            final user = JuzModel.fromJson(data[i]);

            result.add(user);
          }
          return result;
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
