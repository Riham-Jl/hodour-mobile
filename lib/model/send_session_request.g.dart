// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendSessionRequest _$SendSessionRequestFromJson(Map<String, dynamic> json) =>
    SendSessionRequest(
      DateTime.parse(json['session'] as String),
      json['note'] as String?,
      (json['course_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SendSessionRequestToJson(SendSessionRequest instance) =>
    <String, dynamic>{
      'session': instance.session.toIso8601String(),
      'note': instance.note,
      'course_id': instance.course_id,
    };
