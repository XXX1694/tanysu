import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';
import 'package:tanysu/features/profile_preview/data/repositories/profile_preview_repository.dart';

part 'profile_preview_event.dart';
part 'profile_preview_state.dart';

class ProfilePreviewBloc
    extends Bloc<ProfilePreviewEvent, ProfilePreviewState> {
  ProfilePreviewRepository repo;
  ProfilePreviewBloc({
    required this.repo,
    required ProfilePreviewState previewState,
  }) : super(ProfilePreviewInitial()) {
    on<GetUserData>(
      (event, emit) async {
        emit(ProfilePreviewDataGetting());
        ProfileModel? res = await repo.getUser(userId: event.userId);
        if (res != null) {
          emit(ProfilePreviewDataGot(model: res));
        } else {
          emit(ProfilePreviewDataGetError());
        }
      },
    );
  }
}
