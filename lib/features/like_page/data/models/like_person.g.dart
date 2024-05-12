// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikePersonModel _$LikePersonModelFromJson(Map<String, dynamic> json) =>
    LikePersonModel(
      json['id'] as int?,
      json['image'] as Map<String, dynamic>?,
      json['age'] as int?,
      json['first_name'] as String?,
      json['online'] as bool?,
    );

Map<String, dynamic> _$LikePersonModelToJson(LikePersonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'first_name': instance.first_name,
      'age': instance.age,
      'online': instance.online,
    };
