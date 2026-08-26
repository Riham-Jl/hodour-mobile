// lib/model/admin/admin_course.dart

import 'package:json_annotation/json_annotation.dart';

import '../course_user.dart';
import 'admin_user.dart';

part 'admin_course.g.dart';

@JsonSerializable()
class AdminCourse {
  final int id;
  final String name;
  final String? description;
  final String? image;

  @JsonKey(name: 'owner_name')
  final String? ownerName;

  @JsonKey(name: 'members_count', defaultValue: 0)
  final int membersCount;

  @JsonKey(name: 'Sessions_count', defaultValue: 0)
  final int sessionsCount;

  @JsonKey(name: 'users_count', defaultValue: 0)
  final int adminsCount;

  @JsonKey(name: 'owner_email')
  final String? ownerEmail;


  @JsonKey(name: 'users', defaultValue: [])
  final List<UserCourse>? users;

  AdminCourse({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.ownerName,
    required this.membersCount,
    required this.sessionsCount,
    required this.adminsCount,
    this.ownerEmail,
    required this.users,
  });

  factory AdminCourse.fromJson(Map<String, dynamic> json) =>
      _$AdminCourseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCourseToJson(this);
}