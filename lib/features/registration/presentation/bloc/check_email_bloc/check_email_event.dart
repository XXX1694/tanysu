part of 'check_email_bloc.dart';

abstract class CheckEmailEvent extends Equatable {
  const CheckEmailEvent();

  @override
  List<Object> get props => [];
}

class CheckEmail extends CheckEmailEvent {
  final String email;

  const CheckEmail({required this.email});
}
