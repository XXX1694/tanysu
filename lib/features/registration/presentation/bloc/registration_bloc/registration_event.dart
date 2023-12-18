part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class CreateUser extends RegistrationEvent {
  final String email;
  final String password;
  final String name;
  final int city;
  final String birthDate;
  final String gender;
  final String tryToFind;

  const CreateUser({
    required this.email,
    required this.password,
    required this.birthDate,
    required this.city,
    required this.gender,
    required this.name,
    required this.tryToFind,
  });
}
