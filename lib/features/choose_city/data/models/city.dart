import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class CityModel {
  final int id;
  final String name;
  CityModel(
    this.id,
    this.name,
  );
  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
