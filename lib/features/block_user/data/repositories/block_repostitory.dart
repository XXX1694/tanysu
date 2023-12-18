import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/common/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class BlockRepository {
  blockUser({
    required int profileId,
  }) async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}blacklist/$profileId/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    Uri? uri = Uri.tryParse(finalUrl);
    if (uri != null) {
      try {
        final response = await dio.post(
          finalUrl,
          data: jsonEncode(
            {
              // "blocked_user_profile": userId,
            },
          ),
        );
        if (response.statusCode == 201) {
          return 201;
        } else if (response.statusCode == 204) {
          return 204;
        } else {
          return 400;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}
