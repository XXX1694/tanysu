part of 'profile_preview_bloc.dart';

class ProfilePreviewState extends Equatable {
  const ProfilePreviewState();

  @override
  List<Object> get props => [];
}

class ProfilePreviewInitial extends ProfilePreviewState {}

class ProfilePreviewDataGetting extends ProfilePreviewState {}

class ProfilePreviewDataGot extends ProfilePreviewState {
  final ProfileModel model;
  const ProfilePreviewDataGot({required this.model});
}

class ProfilePreviewDataGetError extends ProfilePreviewState {}
