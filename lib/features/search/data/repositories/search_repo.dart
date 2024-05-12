import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';
import 'package:tanysu/features/search/data/models/search_result_model.dart';

final _storage = SharedPreferences.getInstance();

class SearchRepository {
  getUserList({
    required String? gender,
    required int? maxAge,
    required int? minAge,
    required int? cityId,
    required int page,
  }) async {
    final dio = Dio();
    final url = mainUrl;
    var storage = await _storage;
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    String finalUrl;
    finalUrl = '${url}v2/profile/list/';
    try {
      final response = await dio.get(
        finalUrl,
        queryParameters: cityId == null
            ? {
                'page': page,
                'max_age': maxAge ?? 45,
                'min_age': minAge ?? 18,
                'gender': gender,
                'page_size': 20,
              }
            : {
                'page': page,
                'max_age': maxAge ?? 45,
                'min_age': minAge ?? 18,
                'gender': gender,
                'city': cityId,
                'page_size': 20,
              },
      );

      List data = response.data['results'];
      List<SearchResultModel> users = [];
      for (int i = 0; i < data.length; i++) {
        users.add(SearchResultModel.fromJson(data[i]));
      }
      if (response.statusCode == 200) {
        return users;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
