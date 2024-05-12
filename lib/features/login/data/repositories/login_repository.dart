import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class LoginRepository {
  logIn({
    required String email,
    required String password,
  }) async {
    final storage = await _storage;
    String? firebaseToken = storage.getString('firebase_token');
    final url = mainUrl;
    String finalUrl = '${url}users/login/';
    final dio = Dio();

    try {
      final response = await dio.post(
        finalUrl,
        data: jsonEncode(
          {
            'email': email,
            'password': password,
            "firebase": firebaseToken ?? '',
          },
        ),
      );
      if (response.statusCode == 200) {
        storage.setString(
          'auth_token',
          response.data['auth_token'],
        );

        debugPrint(response.data['auth_token']);
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      return 400;
    }
  }
}
