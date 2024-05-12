// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      id: json['id'] as int,
      profile: json['profile'] as Map<String, dynamic>?,
      name: json['name'] as String?,
      last_message: json['last_message'] as Map<String, dynamic>?,
      is_admin_chat: json['is_admin_chat'] as bool,
      is_public: json['is_public'] as bool,
      group_photo: json['group_photo'] as String?,
      online: json['online'] as bool?,
      unread: json['unread'] as int?,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile': instance.profile,
      'last_message': instance.last_message,
      'is_admin_chat': instance.is_admin_chat,
      'is_public': instance.is_public,
      'group_photo': instance.group_photo,
      'unread': instance.unread,
      'online': instance.online,
    };
