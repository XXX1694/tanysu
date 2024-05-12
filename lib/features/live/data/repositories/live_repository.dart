// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _storage = SharedPreferences.getInstance();

class LiveRepository {
  createLive({required stream_id}) async {
    final storage = await _storage;
    String finalUrl = 'http://89.46.33.210:8001/stream/create';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    try {
      final response = await dio.post(
        finalUrl,
        data: jsonEncode(
          {"stream_key": stream_id},
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  deleteLive({required stream_id}) async {
    final storage = await _storage;
    String finalUrl = 'http://89.46.33.210:8001/stream/delete';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    try {
      final response = await dio.post(
        finalUrl,
        data: jsonEncode(
          {"stream_key": stream_id},
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
