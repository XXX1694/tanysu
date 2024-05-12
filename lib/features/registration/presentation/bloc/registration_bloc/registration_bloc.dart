import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/registration/data/repositories/registration_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationRepository repo;
  RegistrationBloc({
    required this.repo,
    required RegistrationState registrationState,
  }) : super(RegistrationInitial()) {
    on<CreateUser>(
      (event, emit) async {
        emit(UserCreating());
        try {
          final res = await repo.register(
            password: event.password,
            email: event.email,
            name: event.name,
            city: event.city,
            gender: event.gender,
            birthDate: event.birthDate,
            tryToFind: event.tryToFind,
          );

          if (res != 0) {
            emit(UserCreated(profileId: res));
          } else {
            emit(const UserCreateError(error: 'Profile create error'));
          }
        } catch (e) {
          emit(const UserCreateError(error: "Profile create error"));
        }
      },
    );
  }
}
