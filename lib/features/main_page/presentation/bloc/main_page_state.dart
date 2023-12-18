part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  const MainPageState();

  @override
  List<Object> get props => [];
}

class MainPageInitial extends MainPageState {}

class UserGot extends MainPageState {
  final List<ProfileModel> users;
  const UserGot({required this.users});
}

class UserGetting extends MainPageState {}

class UserGetError extends MainPageState {}
