// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUser _$AdminUserFromJson(Map<String, dynamic> json) => AdminUser(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      isAdmin: json['is_admin'] as bool,
      type: json['type'] as String,
      allowedCoursesCount: (json['allowed_Courses_count'] as num).toInt(),
      allowedMembersCount: (json['allowed_members_count'] as num).toInt(),
      coursesCount: (json['Courses_count'] as num).toInt(),
      courses: (json['Courses'] as List<dynamic>?)
              ?.map((e) => SimpleCourse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AdminUserToJson(AdminUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'type': instance.type,
      'image': instance.image,
      'allowed_Courses_count': instance.allowedCoursesCount,
      'allowed_members_count': instance.allowedMembersCount,
      'Courses_count': instance.coursesCount,
      'is_admin': instance.isAdmin,
      'Courses': instance.courses,
    };

UserCourse _$UserCourseFromJson(Map<String, dynamic> json) => UserCourse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      admin: (json['admin'] as num).toInt(),
    );

Map<String, dynamic> _$UserCourseToJson(UserCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'admin': instance.admin,
    };

SimpleCourse _$SimpleCourseFromJson(Map<String, dynamic> json) => SimpleCourse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$SimpleCourseToJson(SimpleCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
