import 'package:json_annotation/json_annotation.dart';

part 'send_session_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SendSessionRequest {

  DateTime session;
  String? note;
  int? course_id;
  SendSessionRequest(this.session , this.note ,this.course_id) ;


  factory SendSessionRequest.fromJson(Map<String, dynamic> json) => _$SendSessionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendSessionRequestToJson(this);

}