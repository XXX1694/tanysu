import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';
import 'package:tanysu/common/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class RegistrationRepository {
  register({
    required String email,
    required String password,
    required String name,
    required int city,
    required String gender,
    required String birthDate,
    required String tryToFind,
  }) async {
    final storage = await _storage;
    String? firebaseToken = storage.getString('firebase_token');
    final url = mainUrl;
    String finalUrl = '${url}users/register/';
    final dio = Dio();
    Uri? uri = Uri.tryParse(finalUrl);
    if (uri != null) {
      try {
        if (kDebugMode) {
          print(
            jsonEncode(
              {
                "email": email,
                "password": password,
                "firebase_token": firebaseToken ?? '',
                "profile": {
                  "city": city,
                  "first_name": name,
                  "gender": gender,
                  "try_to_find": tryToFind,
                  "birth_date": birthDate,
                }
              },
            ),
          );
        }
        final response = await dio.post(
          finalUrl,
          data: jsonEncode(
            {
              "email": email,
              "password": password,
              "firebase_token": firebaseToken ?? '',
              "profile": {
                "city": city,
                "first_name": name,
                "gender": gender,
                "try_to_find": tryToFind,
                "birth_date": birthDate,
              }
            },
          ),
        );
        if (kDebugMode) {
          print(response.data);
        }
        Map<String, dynamic> data = response.data;
        if (response.statusCode == 201) {
          storage.setInt('profile_id', data['profile_id']);
          return data['profile_id'];
        } else {
          return 0;
        }
      } catch (e) {
        return '$e';
      }
    }
  }
}
