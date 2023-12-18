import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanysu/features/login/data/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

final _storage = SharedPreferences.getInstance();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository repo;
  LoginBloc({
    required this.repo,
    required LoginState loginState,
  }) : super(LoginInitial()) {
    on<LogIn>(
      (event, emit) async {
        emit(LogingIn());
        final res = await repo.logIn(
          email: event.email,
          password: event.password,
        );
        if (res == 200) {
          emit(LogedIn());
        } else {
          emit(LoginError());
        }
      },
    );
    on<GetUserStatus>(
      (event, emit) async {
        final storage = await _storage;
        String? token = storage.getString('auth_token');
        if (token != null) {
          emit(LogedIn());
        }
      },
    );
  }
}
