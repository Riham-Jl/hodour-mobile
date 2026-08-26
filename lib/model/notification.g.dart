// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyNotification _$MyNotificationFromJson(Map<String, dynamic> json) =>
    MyNotification(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['body'] as String?,
      $enumDecode(_$NotificationTypeEnumMap, json['type']),
      (json['course_id'] as num?)?.toInt(),
      (json['is_critical'] as num?)?.toInt(),
      json['created_at'] as String,
      (json['is_read'] as num).toInt(),
    );

Map<String, dynamic> _$MyNotificationToJson(MyNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'course_id': instance.course_id,
      'is_critical': instance.is_critical,
      'is_read': instance.is_read,
      'created_at': instance.created_at,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.invitation: 'invitation',
  NotificationType.dropUser: 'drop_user',
  NotificationType.answerInvitation: 'answer_invitation',
  NotificationType.withdrawal: 'withdrawal',
  NotificationType.rejectInvitation: 'reject_invitation',
};
