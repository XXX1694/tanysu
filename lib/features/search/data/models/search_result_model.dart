// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'search_result_model.g.dart';

@JsonSerializable()
class SearchResultModel {
  final int id;
  final String? first_name;
  final int? age;
  final Map<String, dynamic> image;
  final String? city_name;
  final bool? online;
  SearchResultModel({
    required this.id,
    required this.age,
    required this.city_name,
    required this.first_name,
    required this.image,
    required this.online,
  });
  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultModelToJson(this);
}
