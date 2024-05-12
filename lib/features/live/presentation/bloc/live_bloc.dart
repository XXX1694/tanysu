import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/live/data/repositories/live_repository.dart';

part 'live_event.dart';
part 'live_state.dart';

class LiveBloc extends Bloc<LiveEvent, LiveState> {
  LiveRepository repo;
  LiveBloc({
    required this.repo,
    required LiveState liveState,
  }) : super(LiveInitial()) {
    on<CreateLive>(
      (event, emit) async {
        emit(LiveCreating());
        bool create = await repo.createLive(stream_id: event.stream_id);
        if (create) {
          emit(LiveCreated());
        } else {
          emit(LiveCreateError());
        }
      },
    );
    on<EndLive>(
      (event, emit) async {
        emit(LiveEnding());
        bool create = await repo.deleteLive(stream_id: event.stream_id);
        if (create) {
          emit(LiveEnded());
        } else {
          emit(LiveEndError());
        }
      },
    );
  }
}
