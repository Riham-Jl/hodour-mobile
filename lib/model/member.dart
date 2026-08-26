import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';


@JsonSerializable(explicitToJson: true)
class Member {
  int id;

  String name;

  String? note;

  bool? attendance;

  Member (this.id , this.name, this.note , this.attendance) ;


  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);

}
