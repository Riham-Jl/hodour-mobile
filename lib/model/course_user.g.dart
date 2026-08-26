// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseUser _$CourseUserFromJson(Map<String, dynamic> json) => CourseUser(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      admin: (json['admin'] as num?)?.toInt(),
      invited: json['invited'] as bool,
    );

Map<String, dynamic> _$CourseUserToJson(CourseUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'admin': instance.admin,
      'invited': instance.invited,
    };
