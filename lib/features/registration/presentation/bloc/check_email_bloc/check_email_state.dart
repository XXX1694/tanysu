part of 'check_email_bloc.dart';

class CheckEmailState extends Equatable {
  const CheckEmailState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends CheckEmailState {}

class EmailChecking extends CheckEmailState {}

class EmailChecked extends CheckEmailState {}

class EmailCheckError extends CheckEmailState {
  final String error;
  const EmailCheckError({required this.error});
}
