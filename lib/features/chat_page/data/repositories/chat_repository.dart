import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';
import 'package:tanysu/features/chat_page/data/models/chat_model.dart';

final _storage = SharedPreferences.getInstance();

class ChatRepository {
  getChatList() async {
    final dio = Dio();
    final url = mainUrl;
    var storage = await _storage;
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    String finalUrl = '${url}chat/list/';

    try {
      final response = await dio.get(finalUrl);
      List data = response.data;
      List<ChatModel> chats = [];
      for (int i = 0; i < data.length; i++) {
        chats.add(ChatModel.fromJson(data[i]));
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

  deleteChat(int chatId) async {
    final dio = Dio();
    final url = mainUrl;
    var storage = await _storage;
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    String finalUrl = '${url}chat/$chatId/deactivate/';
    try {
      final response = await dio.delete(finalUrl);
      if (response.statusCode == 204) {
        return 204;
      } else {
        return 400;
      }
    } catch (e) {
      return 400;
    }
  }
}
