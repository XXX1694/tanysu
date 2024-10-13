// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JuzModel _$JuzModelFromJson(Map<String, dynamic> json) => JuzModel(
      (json['id'] as num?)?.toInt(),
      json['children'] as List<dynamic>?,
      json['icon'] as String?,
      json['name'] as String?,
      (json['parent'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JuzModelToJson(JuzModel instance) => <String, dynamic>{
      'id': instance.id,
      'children': instance.children,
      'name': instance.name,
      'icon': instance.icon,
      'parent': instance.parent,
    };
