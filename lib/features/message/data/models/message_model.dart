// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final int? id;
  final int? chat;
  final int? sender;
  final String? content;
  final String? timestamp;
  final bool? is_svg;
  final bool? is_read;
  MessageModel({
    required this.id,
    required this.chat,
    required this.content,
    required this.sender,
    required this.timestamp,
    required this.is_svg,
    required this.is_read,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
