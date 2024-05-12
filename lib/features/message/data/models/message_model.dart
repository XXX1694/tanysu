// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final int? id;
  final String? content;
  final String? timestamp;
  final int? chat;
  final String? message_type;
  final String? photo;
  final int? sender;
  final String? name;
  final bool? is_read;
  final int? profile_id;
  final bool is_svg;
  MessageModel({
    required this.id,
    required this.chat,
    required this.content,
    required this.sender,
    required this.timestamp,
    required this.message_type,
    required this.photo,
    required this.name,
    required this.is_read,
    required this.profile_id,
    required this.is_svg,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
