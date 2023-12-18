part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class ProfileUpdating extends EditProfileState {}

class ProfileUpdated extends EditProfileState {}

class ProfileUpdateError extends EditProfileState {}
