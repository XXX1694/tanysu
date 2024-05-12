import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tanysu/core/constants/constants.dart';

class CheckNumberRepository {
  checkEmail({
    required String email,
  }) async {
    final url = mainUrl;
    String finalUrl = '${url}users/check-email/';
    final dio = Dio();
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
        return 'success';
      } else {
        return response.data['detail'];
      }
    } catch (e) {
      return '$e';
    }
  }
}
