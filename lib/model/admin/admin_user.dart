import 'package:json_annotation/json_annotation.dart';

part 'admin_user.g.dart';

@JsonSerializable()
class AdminUser {
  final int id;
  final String name;
  final String email;
  final String type;
  final String? image;


  @JsonKey(name: 'allowed_Courses_count')
  final int allowedCoursesCount;

  @JsonKey(name: 'allowed_members_count')
  final int allowedMembersCount;

  @JsonKey(name: 'Courses_count')
  final int coursesCount;

  @JsonKey(name: 'is_admin')
  final bool isAdmin;

  @JsonKey(name: 'Courses', defaultValue: [])
  final List<SimpleCourse>? courses;

  AdminUser({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    required this.isAdmin,
    required this.type,
    required this.allowedCoursesCount,
    required this.allowedMembersCount,
    required this.coursesCount,
    this.courses
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUserFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUserToJson(this);
}

@JsonSerializable()
class UserCourse {
  final int id;
  final String name;
  final String email;
  final int admin;

  UserCourse({
    required this.id,
    required this.name,
    required this.email,
    required this.admin
  });

  factory UserCourse.fromJson(Map<String, dynamic> json) =>
      _$UserCourseFromJson(json);

  Map<String, dynamic> toJson() => _$UserCourseToJson(this);
}


@JsonSerializable()
class SimpleCourse {

  final int id;
  final String name;

  SimpleCourse({
    required this.id,
    required this.name,
  });

  factory SimpleCourse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$SimpleCourseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleCourseToJson(this);
}