import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';

final _storage = SharedPreferences.getInstance();

class AddProfileInfoRepository {
  addProfileInfo({
    String? school,
    String? job,
    String? company,
    String? aboutMe,
    String? juz,
  }) async {
    final url = mainUrl;
    var storage = await _storage;
    int? profileId = storage.getInt('profile_id');
    if (profileId != null) {
      String finalUrl = '${url}profile/update/$profileId/';
      final dio = Dio();
      try {
        final response = await dio.put(
          finalUrl,
          data: jsonEncode(
            {
              // 'try_to_find': lookingFor,
              'profession': job,
              'company_name': company,
              'about_me': aboutMe,
              'school_name': school,
              // 'is_verified': true,
              'juz': juz,
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
}
