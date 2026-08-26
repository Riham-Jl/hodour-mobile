// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminCourse _$AdminCourseFromJson(Map<String, dynamic> json) => AdminCourse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      ownerName: json['owner_name'] as String?,
      membersCount: (json['members_count'] as num?)?.toInt() ?? 0,
      sessionsCount: (json['Sessions_count'] as num?)?.toInt() ?? 0,
      adminsCount: (json['users_count'] as num?)?.toInt() ?? 0,
      ownerEmail: json['owner_email'] as String?,
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => UserCourse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AdminCourseToJson(AdminCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'owner_name': instance.ownerName,
      'members_count': instance.membersCount,
      'Sessions_count': instance.sessionsCount,
      'users_count': instance.adminsCount,
      'owner_email': instance.ownerEmail,
      'users': instance.users,
    };
