import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  }
}
