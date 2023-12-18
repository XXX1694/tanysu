part of 'profile_add_info_bloc.dart';

abstract class ProfileAddInfoEvent extends Equatable {
  const ProfileAddInfoEvent();

  @override
  List<Object> get props => [];
}

class AddInfoProfile extends ProfileAddInfoEvent {
  final String? school;
  final String? job;
  final String? company;
  final String? aboutMe;
  final String? juz;

  const AddInfoProfile({
    required this.aboutMe,
    required this.company,
    required this.job,
    required this.school,
    required this.juz,
  });
}
