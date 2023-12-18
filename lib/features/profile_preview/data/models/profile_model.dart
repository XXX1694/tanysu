// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final int? id;
  final List<Map<String, dynamic>> tags;
  final List<Map<String, dynamic>>? images;
  final String? city_name;
  final bool? matched;
  final int? followers_count;
  final int? age;
  final bool? is_verified;
  final String? first_name;
  final String? birth_date;
  final String? gender;
  final String? try_to_find;
  final String? school_name;
  final String? profession;
  final String? company_name;
  final String? about_me;
  final int? user;
  final int? city;
  final int? reason;
  final bool is_liked;
  final int? completeness;
  final String? juz;

  ProfileModel(
    this.is_liked,
    this.id,
    this.images,
    this.age,
    this.city_name,
    this.first_name,
    this.tags,
    this.about_me,
    this.birth_date,
    this.city,
    this.company_name,
    this.followers_count,
    this.gender,
    this.is_verified,
    this.matched,
    this.profession,
    this.reason,
    this.school_name,
    this.try_to_find,
    this.user,
    this.completeness,
    this.juz,
  );
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
