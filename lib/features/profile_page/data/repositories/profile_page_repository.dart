import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/common/constants/constants.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';

final _storage = SharedPreferences.getInstance();

class ProfileRepository {
  getMyData() async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}profile/me/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    Uri? uri = Uri.tryParse(finalUrl);
    if (uri != null) {
      try {
        final response = await dio.get(
          finalUrl,
        );
        // print(response.data);
        if (response.statusCode == 200) {
          storage.setInt(
              'profile_id', ProfileModel.fromJson(response.data).id ?? 0);
          return ProfileModel.fromJson(response.data);
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

  deleteProfile() async {
    final storage = await _storage;
    final url = mainUrl;
    String finalUrl = '${url}users/delete/';
    final dio = Dio();
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    Uri? uri = Uri.tryParse(finalUrl);
    if (uri != null) {
      try {
        final response = await dio.post(finalUrl);
        if (response.statusCode == 201) {
          return 201;
        } else {
          return response.statusCode;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}