// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'stream_model.g.dart';

@JsonSerializable()
class StreamModel {
  final int id;
  final String? link;
  final String? description;
  final Map<String, dynamic>? profile;
  final String? room_id;
  final int? spectators;

  StreamModel({
    required this.id,
    required this.profile,
    required this.link,
    required this.description,
    required this.room_id,
    required this.spectators,
  });
  factory StreamModel.fromJson(Map<String, dynamic> json) =>
      _$StreamModelFromJson(json);
  Map<String, dynamic> toJson() => _$StreamModelToJson(this);
}
