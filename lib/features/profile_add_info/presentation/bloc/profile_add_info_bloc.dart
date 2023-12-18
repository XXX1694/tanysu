import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/profile_add_info/data/repositories/profile_add_info_repository.dart';

part 'profile_add_info_event.dart';
part 'profile_add_info_state.dart';

class ProfileAddInfoBloc
    extends Bloc<ProfileAddInfoEvent, ProfileAddInfoState> {
  AddProfileInfoRepository repo;
  ProfileAddInfoBloc({
    required this.repo,
    required ProfileAddInfoState profileAddInfoState,
  }) : super(ProfileAddInfoInitial()) {
    on<AddInfoProfile>(
      (event, emit) async {
        emit(AddingProfileInfo());
        try {
          final res = await repo.addProfileInfo(
            school: event.school,
            job: event.job,
            company: event.company,
            aboutMe: event.aboutMe,
            juz: event.juz,
          );
          if (res == 200) {
            emit(AddedProfileInfo());
          } else {
            emit(AddProfileInfoError());
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(AddProfileInfoError());
        }
      },
    );
  }
}
