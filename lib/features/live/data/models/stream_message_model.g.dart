// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamMessageModel _$StreamMessageModelFromJson(Map<String, dynamic> json) =>
    StreamMessageModel(
      message: json['message'] as String?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      profile_id: json['profile_id'] as int?,
    );

Map<String, dynamic> _$StreamMessageModelToJson(StreamMessageModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'name': instance.name,
      'profile_id': instance.profile_id,
      'photo': instance.photo,
    };
