// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      json['is_liked'] as bool,
      json['id'] as int?,
      (json['images'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      json['age'] as int?,
      json['city_name'] as String?,
      json['first_name'] as String?,
      (json['tags'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      json['about_me'] as String?,
      json['birth_date'] as String?,
      json['city'] as int?,
      json['company_name'] as String?,
      json['followers_count'] as int?,
      json['gender'] as String?,
      json['is_verified'] as bool?,
      json['matched'] as bool?,
      json['profession'] as String?,
      json['reason'] as int?,
      json['school_name'] as String?,
      json['try_to_find'] as String?,
      json['user'] as int?,
      json['completeness'] as int?,
      json['juz'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
      'images': instance.images,
      'city_name': instance.city_name,
      'matched': instance.matched,
      'followers_count': instance.followers_count,
      'age': instance.age,
      'is_verified': instance.is_verified,
      'first_name': instance.first_name,
      'birth_date': instance.birth_date,
      'gender': instance.gender,
      'try_to_find': instance.try_to_find,
      'school_name': instance.school_name,
      'profession': instance.profession,
      'company_name': instance.company_name,
      'about_me': instance.about_me,
      'user': instance.user,
      'city': instance.city,
      'reason': instance.reason,
      'is_liked': instance.is_liked,
      'completeness': instance.completeness,
      'juz': instance.juz,
    };
