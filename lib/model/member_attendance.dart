import 'package:hodor/core/functions/date_functions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_attendance.g.dart';


@JsonSerializable(explicitToJson: true)
class MemberAttendance {
  int id;
  int session_id;
  DateTime session;
  int attendance;
  String? note;

  String sessionString(){
    return getStringDateFromDateTime(session);
  }


  MemberAttendance (this.id , this.session_id , this.session, this.attendance ,  this.note) ;


  factory MemberAttendance.fromJson(Map<String, dynamic> json) => _$MemberAttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$MemberAttendanceToJson(this);

}
