// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultModel _$SearchResultModelFromJson(Map<String, dynamic> json) =>
    SearchResultModel(
      id: (json['id'] as num).toInt(),
      age: (json['age'] as num?)?.toInt(),
      city_name: json['city_name'] as String?,
      first_name: json['first_name'] as String?,
      image: json['image'] as Map<String, dynamic>,
      online: json['online'] as bool?,
    );

Map<String, dynamic> _$SearchResultModelToJson(SearchResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'age': instance.age,
      'image': instance.image,
      'city_name': instance.city_name,
      'online': instance.online,
    };
