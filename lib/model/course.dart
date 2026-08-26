import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';


@JsonSerializable(explicitToJson: true)
class Course {
  int id;

  String name;
  String? description;

  bool is_owner;
  int members_count;
  int days_count;
  String? image;

  int pinned;
  DateTime? last_update;

  Course ( this.id , this.name,this.is_owner , this.days_count , this.last_update , this.members_count , this.pinned) ;


  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

}
