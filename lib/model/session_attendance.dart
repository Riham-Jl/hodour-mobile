import 'package:json_annotation/json_annotation.dart';

part 'session_attendance.g.dart';


@JsonSerializable(explicitToJson: true)
class SessionAttendance {
  int id;
  int member_id;
  String member_name;
  int attendance;
  String? note;


  SessionAttendance (this.id , this.member_id , this.member_name, this.attendance ,  this.note) ;


  factory SessionAttendance.fromJson(Map<String, dynamic> json) => _$SessionAttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$SessionAttendanceToJson(this);

}
