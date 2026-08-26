// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberAttendance _$MemberAttendanceFromJson(Map<String, dynamic> json) =>
    MemberAttendance(
      (json['id'] as num).toInt(),
      (json['session_id'] as num).toInt(),
      DateTime.parse(json['session'] as String),
      (json['attendance'] as num).toInt(),
      json['note'] as String?,
    );

Map<String, dynamic> _$MemberAttendanceToJson(MemberAttendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'session_id': instance.session_id,
      'session': instance.session.toIso8601String(),
      'attendance': instance.attendance,
      'note': instance.note,
    };
