// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invitation _$InvitationFromJson(Map<String, dynamic> json) => Invitation(
      (json['id'] as num).toInt(),
      (json['course_id'] as num).toInt(),
      json['course_name'] as String,
      (json['owner_id'] as num).toInt(),
      json['owner_name'] as String,
      json['owner_email'] as String,
    );

Map<String, dynamic> _$InvitationToJson(Invitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.course_id,
      'course_name': instance.course_name,
      'owner_id': instance.owner_id,
      'owner_name': instance.owner_name,
      'owner_email': instance.owner_email,
    };
