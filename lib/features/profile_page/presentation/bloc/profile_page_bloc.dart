import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/profile_page/data/repositories/profile_page_repository.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfileRepository repo;
  ProfilePageBloc({
    required this.repo,
    required ProfilePageState profilePageState,
  }) : super(ProfilePageInitial()) {
    on<GetMyData>(
      (event, emit) async {
        emit(ProfileGetting());
        ProfileModel? res = await repo.getMyData();
        if (res != null) {
          emit(ProfileGot(model: res));
        } else {
          emit(ProfileGetError());
        }
      },
    );
    on<DeleteProfile>(
      (event, emit) async {
        int res = await repo.deleteProfile();
        if (res == 201) {
          emit(ProfileDeleted());
        } else {
          if (kDebugMode) {
            print(res);
          }
        }
      },
    );
  }
}
