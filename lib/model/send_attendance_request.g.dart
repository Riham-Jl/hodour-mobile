// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_attendance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendAttendanceRequest _$SendAttendanceRequestFromJson(
        Map<String, dynamic> json) =>
    SendAttendanceRequest(
      (json['course_id'] as num).toInt(),
      (json['session_id'] as num).toInt(),
      (json['sessionAttendance'] as List<dynamic>)
          .map((e) => SessionAttendance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SendAttendanceRequestToJson(
        SendAttendanceRequest instance) =>
    <String, dynamic>{
      'course_id': instance.course_id,
      'session_id': instance.session_id,
      'sessionAttendance':
          instance.sessionAttendance.map((e) => e.toJson()).toList(),
    };
