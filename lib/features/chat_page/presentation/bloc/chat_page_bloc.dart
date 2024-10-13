import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/chat_page/data/models/chat_model.dart';
import 'package:tanysu/features/chat_page/data/repositories/chat_repository.dart';

part 'chat_page_event.dart';
part 'chat_page_state.dart';

class ChatPageBloc extends Bloc<ChatPageEvent, ChatPageState> {
  ChatRepository repo;
  ChatPageBloc({
    required this.repo,
    required ChatPageState chatPageState,
  }) : super(ChatPageInitial()) {
    on<UpdateAllChats>(
      (event, emit) async {
        try {
          bool res = await repo.getChatList();
          if (res) {
            if (kDebugMode) {
              print('Список чата обновился');
            }
          } else {
            if (kDebugMode) {
              print('Ошибка при обновлении чата');
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print("Ошибка при обновлении чата: $e");
          }
          emit(ChatListGetError());
        }
      },
    );
    on<DeleteChat>(
      (event, emit) async {
        emit(ChatDeleting());
        try {
          await repo.deleteChat(event.chatId);
          emit(ChatDeleted());
        } catch (e) {
          emit(ChatDeleteError());
        }
      },
    );
  }
}

bool haveLastMessagesChanged(List<ChatModel> oldList, List<ChatModel> newList) {
  if (oldList.length != newList.length) {
    return true;
  }
  for (int i = 0; i < oldList.length; i++) {
    if (oldList[i].last_message != newList[i].last_message) {
      return true; // Different chat, assume change in last message
    }
  }

  return false; // No changes detected in last messages
}
