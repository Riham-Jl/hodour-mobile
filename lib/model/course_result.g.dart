// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseResult _$CourseResultFromJson(Map<String, dynamic> json) => CourseResult(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['attendance'] as String,
      (json['all_days'] as num).toInt(),
      json['percentage'] as String,
    );

Map<String, dynamic> _$CourseResultToJson(CourseResult instance) =>
    <String, dynamic>{
      'id': instance.member_id,
      'name': instance.name,
      'attendance': instance.attendance,
      'all_days': instance.all_days,
      'percentage': instance.percentage,
    };
