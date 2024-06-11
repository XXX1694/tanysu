import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/core/constants/chats.dart';
import 'package:tanysu/features/stream/data/models/stream_model.dart';
import 'package:tanysu/features/stream/data/repository/stream_repository.dart';

part 'stream_event.dart';
part 'stream_state.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  StreamRepository repo;
  StreamBloc({
    required this.repo,
    required StreamState streamState,
  }) : super(StreamInitial()) {
    on<GetAllStream>(
      (event, emit) async {
        emit(StreamListGetting());
        List<StreamModel> streamList = await repo.getStreamList();
        if (streamList.isEmpty) {
          emit(StreamListGetError());
        } else {
          emit(StreamListGot(streamList: streamList));
        }
      },
    );
    on<UpdateAllStream>(
      (event, emit) async {
        List<StreamModel> streamList = await repo.getStreamList();
        if (haveStreamListChanged(streamList, streamListGlobal)) {
          emit(StreamListGetting());
          emit(StreamListGot(streamList: streamList));
        }
      },
    );
  }
}

bool haveStreamListChanged(
    List<StreamModel> oldList, List<StreamModel> newList) {
  if (oldList.length != newList.length) {
    return true;
  }
  // for (int i = 0; i < oldList.length; i++) {
  //   if (oldList[i].last_message!['content'] !=
  //       newList[i].last_message!['content']) {
  //     return true; // Different chat, assume change in last message
  //   }
  //   // if (oldList[i].last_message != newList[i].last_message) {
  //   //   return true; // Last message has changed
  //   // }
  // }

  return false; // No changes detected in last messages
}
