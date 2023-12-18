import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/main_page/data/repositories/user_get_repository.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  UserGetRepository repo;
  MainPageBloc({
    required this.repo,
    required MainPageState mainPageState,
  }) : super(MainPageInitial()) {
    on<GetUsers>(
      (event, emit) async {
        emit(UserGetting());
        try {
          List<ProfileModel>? res = await repo.getRandomUsers();
          if (res != null) {
            emit(UserGot(users: res));
          } else {
            emit(UserGetError());
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(UserGetError());
        }
      },
    );
    on<GetMoreUsers>(
      (event, emit) async {
        List<ProfileModel>? res = await repo.getRandomUsers();
        if (res != null) {
          emit(UserGot(users: res));
        }
      },
    );
    on<Like>(
      (event, emit) async {
        try {
          await repo.like(profileId: event.profileId);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
    );
    on<DisLike>(
      (event, emit) async {
        try {
          await repo.dislike(profileId: event.profileId);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
    );
    on<UnLike>(
      (event, emit) async {
        try {
          if (kDebugMode) {
            print(event.profileId);
          }
          await repo.unlike(profileId: event.profileId);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
    );
  }
}
