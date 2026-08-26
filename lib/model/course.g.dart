// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['is_owner'] as bool,
      (json['days_count'] as num).toInt(),
      json['last_update'] == null
          ? null
          : DateTime.parse(json['last_update'] as String),
      (json['members_count'] as num).toInt(),
      (json['pinned'] as num).toInt(),
    )
      ..description = json['description'] as String?
      ..image = json['image'] as String?;

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'is_owner': instance.is_owner,
      'members_count': instance.members_count,
      'days_count': instance.days_count,
      'image': instance.image,
      'pinned': instance.pinned,
      'last_update': instance.last_update?.toIso8601String(),
    };
