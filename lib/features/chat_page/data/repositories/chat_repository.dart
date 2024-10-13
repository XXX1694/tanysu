import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/core/constants/constants.dart';
import 'package:tanysu/features/chat_page/data/models/chat_model.dart';

final _storage = SharedPreferences.getInstance();

class ChatRepository {
  Future<bool> getChatList() async {
    final dio = Dio();
    final url = mainUrl;
    var storage = await _storage;
    String finalUrl = '${url}v3/chat/list/';

    String? token = storage.getString('auth_token');
    if (token == null) return false;

    dio.options.headers["authorization"] = "Token $token";

    try {
      final response = await dio.get(
        finalUrl,
        queryParameters: {
          'page': 1,
          'page_size': 30,
        },
      );
      if (response.statusCode != 200) {
        return false;
      }

      List data = response.data['results'];
      List<ChatModel> chats = [];
      for (int i = 0; i < data.length; i++) {
        ChatModel chat = ChatModel.fromJson(data[i]);
        chats.add(chat);
      }
      final chatBox = Hive.box<ChatModel>('chatBox');

      // Optionally clear existing data
      await chatBox.clear();

      // Save each chat using its id as the key
      for (var chat in chats) {
        await chatBox.put(chat.id, chat);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<ChatModel> getLocalChatList() {
    final chatBox = Hive.box<ChatModel>('chatBox');
    return chatBox.values.toList();
  }

  Future<void> deleteChat(int chatId) async {
    final dio = Dio();
    final url = mainUrl;
    var storage = await _storage;
    String? token = storage.getString('auth_token');
    if (token == null) return;
    dio.options.headers["authorization"] = "Token $token";
    String finalUrl = '${url}chat/$chatId/deactivate/';
    try {
      final response = await dio.delete(finalUrl);
      if (response.statusCode == 204) {}
    } catch (e) {
      // Handle the error
    }
  }
}
