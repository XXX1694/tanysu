part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfile extends EditProfileEvent {
  final int? profileId;
  final String? name;
  final String? birthDate;
  final String? gender;
  final int? city;
  final String? job;
  final String? company;
  final String? school;
  final String? about;
  final String? juz;

  const UpdateProfile({
    required this.about,
    required this.birthDate,
    required this.city,
    required this.company,
    required this.gender,
    required this.job,
    required this.name,
    required this.profileId,
    required this.school,
    required this.juz,
  });
}
