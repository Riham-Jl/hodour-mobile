import 'package:json_annotation/json_annotation.dart';

part 'course_result.g.dart';


@JsonSerializable(explicitToJson: true)
class CourseResult {

  @JsonKey(name: "id")
   int member_id;

  String name;

  String attendance;

  int all_days;

  String percentage;

  int attendanceNum(){
    return int.parse(attendance);
  }

  double percentageNum(){
    return double.parse(percentage);
  }

  bool success(){
    return percentageNum()>=50;
  }


  CourseResult (this.member_id , this.name, this.attendance , this.all_days , this.percentage) ;


  factory CourseResult.fromJson(Map<String, dynamic> json) => _$CourseResultFromJson(json);

  Map<String, dynamic> toJson() => _$CourseResultToJson(this);

}
