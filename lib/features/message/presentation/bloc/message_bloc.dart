import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/message/data/models/message_model.dart';
import 'package:tanysu/features/message/data/repositories/message_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageRepository repo;

  MessageBloc({
    required this.repo,
    required MessageState messageState,
  }) : super(MessageInitial()) {
    on<GetAllMessages>(
      (event, emit) async {
        emit(MessageGetting());
        try {
          List<MessageModel> res = await repo.getChatInfo(event.chatId);

          emit(MessageGot(messages: res));
        } catch (e) {
          emit(MessageGetError());
        }
      },
    );
    on<GetAllGroupMessages>(
      (event, emit) async {
        emit(MessageGetting());
        try {
          List<MessageModel> res = await repo.getPublicChatInfo(
            page: event.page,
          );
          emit(MessageGot(messages: res));
        } catch (e) {
          emit(MessageGetError());
        }
      },
    );
    on<UpdateAllGroupMessages>(
      (event, emit) async {
        try {
          List<MessageModel> res = await repo.getPublicChatInfo(
            page: event.page,
          );
          emit(MessageUpdated(messages: res));
        } catch (e) {
          emit(MessageGetError());
        }
      },
    );
    on<Reset>(
      (event, emit) => emit(MessageInitial()),
    );
  }
}
