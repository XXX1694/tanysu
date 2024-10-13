// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      (json['id'] as num?)?.toInt(),
      (json['images'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      (json['age'] as num?)?.toInt(),
      json['city_name'] as String?,
      json['first_name'] as String?,
      (json['tags'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'images': instance.images,
      'first_name': instance.first_name,
      'city_name': instance.city_name,
      'age': instance.age,
      'tags': instance.tags,
    };
