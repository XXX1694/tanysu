// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'stream_message_model.g.dart';

@JsonSerializable()
class StreamMessageModel {
  final String? message;
  final String? name;
  final int? profile_id;
  final String? photo;

  StreamMessageModel({
    required this.message,
    required this.name,
    required this.photo,
    required this.profile_id,
  });
  factory StreamMessageModel.fromJson(Map<String, dynamic> json) =>
      _$StreamMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$StreamMessageModelToJson(this);
}

// "message": event["message"],
// "name": event["name"],
// "profile_id": event["profile_id"],
// "photo": photo,
