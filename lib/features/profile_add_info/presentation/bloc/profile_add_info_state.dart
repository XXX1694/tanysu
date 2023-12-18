part of 'profile_add_info_bloc.dart';

class ProfileAddInfoState extends Equatable {
  const ProfileAddInfoState();

  @override
  List<Object> get props => [];
}

class ProfileAddInfoInitial extends ProfileAddInfoState {}

class AddingProfileInfo extends ProfileAddInfoState {}

class AddedProfileInfo extends ProfileAddInfoState {}

class AddProfileInfoError extends ProfileAddInfoState {}
