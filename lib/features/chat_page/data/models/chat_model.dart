// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 0) // Ensure typeId is unique across all your models
@JsonSerializable()
class ChatModel extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int? profile_id;

  @HiveField(2)
  final String? chat_name;

  @HiveField(3)
  final String chat_type;

  @HiveField(4)
  final String? last_message;

  @HiveField(5)
  final String? chat_photo;

  @HiveField(6)
  final int? unread;

  @HiveField(7)
  final bool? online;

  @HiveField(8)
  final DateTime? last_message_time;

  const ChatModel({
    required this.id,
    required this.profile_id,
    required this.chat_name,
    required this.chat_type,
    required this.last_message,
    required this.chat_photo,
    required this.unread,
    required this.online,
    required this.last_message_time,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        profile_id,
        chat_name,
        chat_type,
        last_message,
        chat_photo,
        unread,
        online,
        last_message_time,
      ];
}
