import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class EditProfileRepository {
  editProfile({
    required int? profileId,
    required String? name,
    required String? birthDate,
    required String? gender,
    required int? city,
    required String? job,
    required String? company,
    required String? school,
    required String? about,
    required String? juz,
    required String? tryToFind,
  }) async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}profile/update/$profileId/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    try {
      debugPrint(
        jsonEncode(
          {
            'city': city,
            'first_name': name,
            'birth_date': birthDate,
            'gender': gender,
            'school_name': school,
            'profession': job,
            'company_name': company,
            'about_me': about,
            'juz': juz,
            'try_to_find': tryToFind,
          },
        ),
      );
      final response = await dio.put(
        finalUrl,
        data: jsonEncode(
          {
            'city': city,
            'first_name': name,
            'birth_date': birthDate,
            'gender': gender,
            'school_name': school,
            'profession': job,
            'company_name': company,
            'about_me': about,
            'juz': juz,
            'try_to_find': tryToFind,
          },
        ),
      );
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      return 400;
    }
  }
}
