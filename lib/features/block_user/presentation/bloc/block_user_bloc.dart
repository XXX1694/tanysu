import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/block_user/data/repositories/block_repostitory.dart';

part 'block_user_event.dart';
part 'block_user_state.dart';

class BlockUserBloc extends Bloc<BlockUserEvent, BlockUserState> {
  BlockRepository repo;
  BlockUserBloc({
    required this.repo,
    required BlockUserState blockUserState,
  }) : super(BlockUserInitial()) {
    on<BlockUser>(
      (event, emit) async {
        emit(UserBlocking());
        try {
          final res = await repo.blockUser(profileId: event.profileId);
          if (res == 201) {
            emit(UserBlocked());
          } else if (res == 204) {
            emit(UserUnBlocked());
          } else {
            emit(UserBlockError());
          }
        } catch (e) {
          emit(UserBlockError());
        }
      },
    );
  }
}
