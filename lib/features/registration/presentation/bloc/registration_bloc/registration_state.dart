part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class UserCreating extends RegistrationState {}

class UserCreated extends RegistrationState {
  final int profileId;
  const UserCreated({required this.profileId});
}

class UserCreateError extends RegistrationState {
  final String error;
  const UserCreateError({required this.error});
}
