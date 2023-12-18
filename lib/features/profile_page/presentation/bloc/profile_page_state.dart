part of 'profile_page_bloc.dart';

class ProfilePageState extends Equatable {
  const ProfilePageState();

  @override
  List<Object> get props => [];
}

class ProfilePageInitial extends ProfilePageState {}

class ProfileGetting extends ProfilePageState {}

class ProfileGot extends ProfilePageState {
  final ProfileModel model;
  const ProfileGot({required this.model});
}

class ProfileGetError extends ProfilePageState {}

class ProfileDeleted extends ProfilePageState {}
