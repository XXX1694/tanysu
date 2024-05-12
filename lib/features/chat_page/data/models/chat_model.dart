// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  final int id;
  final String? name;
  final Map<String, dynamic>? profile;
  final Map<String, dynamic>? last_message;
  final bool is_admin_chat;
  final bool is_public;
  final String? group_photo;
  final int? unread;
  final bool? online;
  ChatModel({
    required this.id,
    required this.profile,
    required this.name,
    required this.last_message,
    required this.is_admin_chat,
    required this.is_public,
    required this.group_photo,
    required this.online,
    required this.unread,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
