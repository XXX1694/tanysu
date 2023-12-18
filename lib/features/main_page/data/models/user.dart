// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  final List<Map<String, dynamic>> images;
  final String? first_name;
  final String? city_name;
  final int? age;
  final List<Map<String, dynamic>> tags;
  UserModel(
    this.id,
    this.images,
    this.age,
    this.city_name,
    this.first_name,
    this.tags,
  );
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
