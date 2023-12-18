import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tanysu/common/constants/constants.dart';

class CheckNumberRepository {
  checkEmail({
    required String email,
  }) async {
    final url = mainUrl;
    String finalUrl = '${url}users/check-email/';
    final dio = Dio();
    Uri? uri = Uri.tryParse(finalUrl);
    if (uri != null) {
      try {
        final response = await dio.post(
          finalUrl,
          data: jsonEncode(
            {
              'email': email,
            },
          ),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> data = response.data;
          if (kDebugMode) {
            print('Data: $data');
          }
          return 'success';
        } else {
          return response.data['detail'];
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return '$e';
      }
    }
  }
}
