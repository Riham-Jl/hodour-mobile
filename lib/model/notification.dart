import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

enum NotificationType {
  @JsonValue('invitation')
  invitation,

  @JsonValue('drop_user')
  dropUser,

  @JsonValue('answer_invitation')
  answerInvitation,

  @JsonValue('withdrawal')
  withdrawal,

  @JsonValue('reject_invitation')
  rejectInvitation,
}

extension NotificationTypeParser on NotificationType {
  static NotificationType? fromString(String? value) {
    if (value == null) return null;

    for (final type in NotificationType.values) {
      if (type.name == value) return type;
    }

    return null;
  }
}

@JsonSerializable(explicitToJson: true)
class MyNotification {
  int id;

  String title;

  String? body;

  NotificationType type;

  int? course_id;
  int? is_critical;
  int is_read;
  String created_at;

  @JsonKey(name: "created_at")
  DateTime get createdAtLocal {
    return DateTime.parse(created_at).toLocal() ;
  }

  Duration get notificationTime {
    Duration difference = DateTime.now().difference(DateTime.parse(createdAtLocal.toString()));
    return difference;
  }



  MyNotification ( this.id , this.title, this.body , this.type , this.course_id , this.is_critical ,this.created_at, this.is_read) ;


  factory MyNotification.fromJson(Map<String, dynamic> json) => _$MyNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$MyNotificationToJson(this);

}
