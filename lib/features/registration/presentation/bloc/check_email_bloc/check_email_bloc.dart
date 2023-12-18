import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/registration/data/repositories/check_email_repository.dart';

part 'check_email_event.dart';
part 'check_email_state.dart';

class CheckEmailBloc extends Bloc<CheckEmailEvent, CheckEmailState> {
  CheckNumberRepository repo;
  CheckEmailBloc({
    required this.repo,
    required CheckEmailState checkEmailState,
  }) : super(RegistrationInitial()) {
    on<CheckEmail>(
      (event, emit) async {
        emit(EmailChecking());
        final res = await repo.checkEmail(
          email: event.email,
        );
        if (res == 'success') {
          emit(EmailChecked());
        } else {
          emit(EmailCheckError(error: res));
        }
      },
    );
  }
}
