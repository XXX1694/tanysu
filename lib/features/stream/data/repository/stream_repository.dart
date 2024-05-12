import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';
import 'package:tanysu/features/stream/data/models/stream_model.dart';

final _storage = SharedPreferences.getInstance();

class StreamRepository {
  Future<List<StreamModel>> getStreamList() async {
    final dio = Dio();
    final url = mainUrl;
    final storage = await _storage;
    String? token = storage.getString('auth_token');
    if (token == null) return [];
    dio.options.headers["authorization"] = "Token $token";
    String finalUrl = '${url}stream/list/';
    try {
      final response = await dio.get(finalUrl);
      List data = response.data;
      // print(response.data);
      List<StreamModel> streams = [];
      for (int i = 0; i < data.length; i++) {
        streams.add(StreamModel.fromJson(data[i]));
      }
      if (response.statusCode == 200) {
        return streams;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
