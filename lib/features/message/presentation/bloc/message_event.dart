part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetAllMessages extends MessageEvent {
  final int chatId;
  const GetAllMessages({
    required this.chatId,
  });
}

class GetAllGroupMessages extends MessageEvent {
  final int page;
  const GetAllGroupMessages({
    required this.page,
  });
}

class UpdateAllGroupMessages extends MessageEvent {
  final int page;
  const UpdateAllGroupMessages({
    required this.page,
  });
}

class Reset extends MessageEvent {}
