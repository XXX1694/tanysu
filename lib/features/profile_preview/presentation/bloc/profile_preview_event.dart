part of 'profile_preview_bloc.dart';

abstract class ProfilePreviewEvent extends Equatable {
  const ProfilePreviewEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends ProfilePreviewEvent {
  final int userId;
  const GetUserData({required this.userId});
}

class FollowUnfollow extends ProfilePreviewEvent {
  final int profileId;
  const FollowUnfollow({required this.profileId});
}
