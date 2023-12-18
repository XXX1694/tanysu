part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class UserLoggingOut extends SettingsState {}

class UserLoggedOut extends SettingsState {}

class UserLogOutError extends SettingsState {}
