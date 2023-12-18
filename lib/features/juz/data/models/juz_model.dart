import 'package:json_annotation/json_annotation.dart';

part 'juz_model.g.dart';

@JsonSerializable()
class JuzModel {
  final int? id;
  final List? children;
  final String? name;
  final String? icon;
  final int? parent;
  JuzModel(
    this.id,
    this.children,
    this.icon,
    this.name,
    this.parent,
  );
  factory JuzModel.fromJson(Map<String, dynamic> json) =>
      _$JuzModelFromJson(json);
  Map<String, dynamic> toJson() => _$JuzModelToJson(this);
}
