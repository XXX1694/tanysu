import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';
import 'package:tanysu/features/message/data/models/message_model.dart';

final _storage = SharedPreferences.getInstance();

class MessageRepository {
  getChatInfo(int chatId) async {
    final dio = Dio();
    final url = mainUrl;
    var storage = await _storage;
    String? token = storage.getString('auth_token');
    // print(token);
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    String finalUrl = '${url}v2/chat/message/list/$chatId/';
    try {
      final response = await dio.get(finalUrl);

      List data = response.data['results'];
      List<MessageModel> chats = [];
      for (int i = 0; i < data.length; i++) {
        chats.add(MessageModel.fromJson(data[i]));
      }
      if (response.statusCode == 200) {
        return chats;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  getPublicChatInfo({
    required int page,
  }) async {
    final dio = Dio();
    var storage = await _storage;
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    String finalUrl = 'https://tanysu.net/chat/message/list/1514/public/';
    try {
      final response = await dio.get(
        finalUrl,
        queryParameters: {
          "page": page,
          "page_size": 20,
        },
      );
      // print(response.data);
      List data = response.data['results'];
      List<MessageModel> chats = [];
      for (int i = 0; i < data.length; i++) {
        chats.add(MessageModel.fromJson(data[i]));
      }
      if (response.statusCode == 200) {
        return chats;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
