// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_members_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMembersRequest _$SendMembersRequestFromJson(Map<String, dynamic> json) =>
    SendMembersRequest(
      (json['members'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      (json['course_id'] as num).toInt(),
      (json['session_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SendMembersRequestToJson(SendMembersRequest instance) =>
    <String, dynamic>{
      'members': instance.members,
      'course_id': instance.course_id,
      'session_id': instance.session_id,
    };
