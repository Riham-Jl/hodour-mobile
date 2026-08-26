import 'package:json_annotation/json_annotation.dart';

part 'invitation.g.dart';


@JsonSerializable(explicitToJson: true)
class Invitation {
  int id;

  int course_id;

  String course_name;

  int owner_id;

  String owner_name;

  String owner_email;

  Invitation (this.id ,this.course_id, this.course_name,this.owner_id, this.owner_name , this.owner_email) ;


  factory Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationToJson(this);

}
