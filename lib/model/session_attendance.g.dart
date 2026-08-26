// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionAttendance _$SessionAttendanceFromJson(Map<String, dynamic> json) =>
    SessionAttendance(
      (json['id'] as num).toInt(),
      (json['member_id'] as num).toInt(),
      json['member_name'] as String,
      (json['attendance'] as num).toInt(),
      json['note'] as String?,
    );

Map<String, dynamic> _$SessionAttendanceToJson(SessionAttendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.member_id,
      'member_name': instance.member_name,
      'attendance': instance.attendance,
      'note': instance.note,
    };
