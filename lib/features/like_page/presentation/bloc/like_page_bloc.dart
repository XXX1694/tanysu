import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/like_page/data/models/like_person.dart';
import 'package:tanysu/features/like_page/data/repositories/like_repository.dart';

part 'like_page_event.dart';
part 'like_page_state.dart';

class LikePageBloc extends Bloc<LikePageEvent, LikePageState> {
  LikeRepository repo;
  LikePageBloc({
    required this.repo,
    required LikePageState likePageState,
  }) : super(LikePageInitial()) {
    on<GetLikes>(
      (event, emit) async {
        emit(LikeGetting());

        try {
          List<LikePersonModel>? res1 = await repo.likesMe();
          List<LikePersonModel>? res2 = await repo.meLike();
          await Future.delayed(const Duration(milliseconds: 200));
          emit(LikeGot(
            likesMe: res1 ?? [],
            meLike: res2 ?? [],
          ));
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(LikeGetError());
        }
      },
    );
  }
}
