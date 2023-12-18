import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/settings/data/repositories/user_logout_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  UserLogOutRepository repo;

  SettingsBloc({
    required this.repo,
    required SettingsState settingsState,
  }) : super(SettingsInitial()) {
    on<UserLogOut>(
      (event, emit) async {
        emit(UserLoggingOut());
        try {
          repo.logOut();
          emit(UserLoggedOut());
        } catch (e) {
          emit(UserLogOutError());
        }
      },
    );
  }
}
