import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/edit_profile/data/repositories/edit_profile_repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileRepository repo;
  EditProfileBloc({
    required this.repo,
    required EditProfileState editProfileState,
  }) : super(EditProfileInitial()) {
    on<UpdateProfile>(
      (event, emit) async {
        emit(ProfileUpdating());
        try {
          final res = await repo.editProfile(
            profileId: event.profileId,
            name: event.name,
            birthDate: event.birthDate,
            gender: event.gender,
            city: event.city,
            job: event.job,
            company: event.company,
            school: event.school,
            about: event.about,
            juz: event.juz,
            tryToFind: event.tryToFind,
          );
          if (kDebugMode) {
            print(res);
          }
          if (res == 200) {
            emit(ProfileUpdated());
          } else {
            emit(ProfileUpdateError());
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(ProfileUpdateError());
        }
      },
    );
  }
}
