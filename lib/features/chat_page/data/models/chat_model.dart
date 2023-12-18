// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  final int id;
  final Map<String, dynamic> profile;
  final Map<String, dynamic>? last_message;
  final bool is_admin_chat;
  ChatModel({
    required this.id,
    required this.profile,
    required this.last_message,
    required this.is_admin_chat,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
