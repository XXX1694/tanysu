// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'like_person.g.dart';

@JsonSerializable()
class LikePersonModel {
  final int? id;
  final Map<String, dynamic>? image;
  final String? first_name;
  final int? age;
  final bool? online;
  LikePersonModel(
    this.id,
    this.image,
    this.age,
    this.first_name,
    this.online,
  );
  factory LikePersonModel.fromJson(Map<String, dynamic> json) =>
      _$LikePersonModelFromJson(json);
  Map<String, dynamic> toJson() => _$LikePersonModelToJson(this);
}
