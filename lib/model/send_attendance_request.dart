import 'package:hodor/model/session_attendance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_attendance_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SendAttendanceRequest {

  int course_id;
  int session_id;
  List<SessionAttendance> sessionAttendance;
  SendAttendanceRequest( this.course_id ,this.session_id , this.sessionAttendance) ;


  factory SendAttendanceRequest.fromJson(Map<String, dynamic> json) => _$SendAttendanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendAttendanceRequestToJson(this);

}