import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/core/constants/chats.dart';
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
    on<GetAllChats>(
      (event, emit) async {
        emit(ChatListGetting());
        try {
          List<ChatModel> res = await repo.getChatList();
          emit(ChatListGot(chats: res));
        } catch (e) {
          emit(ChatListGetError());
        }
      },
    );
    on<UpdateAllChats>(
      (event, emit) async {
        try {
          List<ChatModel> res = await repo.getChatList();
          if (haveLastMessagesChanged(res, chats)) {
            emit(ChatListGetting());
            emit(ChatListGot(chats: res));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(ChatListGetError());
        }
      },
    );
    on<DeleteChat>(
      (event, emit) async {
        emit(ChatDeleting());
        try {
          int res = await repo.deleteChat(event.chatId);
          if (res == 204) {
            emit(ChatDeleted());
          } else {
            emit(ChatDeleteError());
          }
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
    if (oldList[i].last_message!['content'] !=
        newList[i].last_message!['content']) {
      return true; // Different chat, assume change in last message
    }
    // if (oldList[i].last_message != newList[i].last_message) {
    //   return true; // Last message has changed
    // }
  }

  return false; // No changes detected in last messages
}
