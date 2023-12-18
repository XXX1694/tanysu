import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/common/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class ReportRepository {
  reportProfile({
    required String description,
    required int category,
    required int recipient,
  }) async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}complaint/';
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
        final response = await dio.post(
          finalUrl,
          data: jsonEncode(
            {
              "description": description,
              "category": category,
              "recipient": recipient,
            },
          ),
        );
        if (kDebugMode) {
          print(response.data);
        }
        if (response.statusCode == 201) {
          return 201;
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
