import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';

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

    try {
      final response = await dio.get(finalUrl);
      List<dynamic> data = response.data;

      if (response.statusCode == 200) {
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  sendGift({
    required int giftId,
    required int receiver,
  }) async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}gift/send/v2/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";

    try {
      final response = await dio.post(
        finalUrl,
        data: jsonEncode(
          {
            "gift_number": giftId,
            "receiver": receiver,
            "message": "",
          },
        ),
      );
      // print(response.data);
      if (response.statusCode == 201) {
        return 201;
      } else {
        return 400;
      }
    } catch (e) {
      // print(e);
      return 400;
    }
  }
}
