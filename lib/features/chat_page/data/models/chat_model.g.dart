// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      id: json['id'] as int,
      profile: json['profile'] as Map<String, dynamic>,
      last_message: json['last_message'] as Map<String, dynamic>?,
      is_admin_chat: json['is_admin_chat'] as bool,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'profile': instance.profile,
      'last_message': instance.last_message,
      'is_admin_chat': instance.is_admin_chat,
    };
