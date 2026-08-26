import 'package:json_annotation/json_annotation.dart';

part 'course_user.g.dart';

@JsonSerializable(explicitToJson: true)
class CourseUser {
  int id;
  String name;
  String email;
  int? admin;
  bool invited;


  bool isOwner() {
      return admin==1;
  }

  CourseUser({required this.id, required this.name , required this.email ,  required this.admin  ,required this.invited});


  factory CourseUser.fromJson(Map<String, dynamic> json) => _$CourseUserFromJson(json);

  Map<String, dynamic> toJson() => _$CourseUserToJson(this);


}
