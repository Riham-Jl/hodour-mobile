import 'package:json_annotation/json_annotation.dart';

part 'send_members_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SendMembersRequest {

  List<Map> members;
  int course_id;
  int? session_id;
  SendMembersRequest(this.members , this.course_id ,this.session_id) ;


  factory SendMembersRequest.fromJson(Map<String, dynamic> json) => _$SendMembersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendMembersRequestToJson(this);

}