// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'] as int?,
      chat: json['chat'] as int?,
      content: json['content'] as String?,
      sender: json['sender'] as int?,
      timestamp: json['timestamp'] as String?,
      message_type: json['message_type'] as String?,
      photo: json['photo'] as String?,
      name: json['name'] as String?,
      is_read: json['is_read'] as bool?,
      profile_id: json['profile_id'] as int?,
      is_svg: json['is_svg'] as bool,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'timestamp': instance.timestamp,
      'chat': instance.chat,
      'message_type': instance.message_type,
      'photo': instance.photo,
      'sender': instance.sender,
      'name': instance.name,
      'is_read': instance.is_read,
      'profile_id': instance.profile_id,
      'is_svg': instance.is_svg,
    };
