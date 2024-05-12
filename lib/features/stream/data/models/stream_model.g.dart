// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamModel _$StreamModelFromJson(Map<String, dynamic> json) => StreamModel(
      id: json['id'] as int,
      profile: json['profile'] as Map<String, dynamic>?,
      link: json['link'] as String?,
      description: json['description'] as String?,
      room_id: json['room_id'] as String?,
      spectators: json['spectators'] as int?,
    );

Map<String, dynamic> _$StreamModelToJson(StreamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'description': instance.description,
      'profile': instance.profile,
      'room_id': instance.room_id,
      'spectators': instance.spectators,
    };
