// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminDashboard _$AdminDashboardFromJson(Map<String, dynamic> json) =>
    AdminDashboard(
      usersCount: (json['users_count'] as num).toInt(),
      coursesCount: (json['Courses_count'] as num).toInt(),
      membersCount: (json['members_count'] as num).toInt(),
      sessionsCount: (json['sessions_count'] as num).toInt(),
    );

Map<String, dynamic> _$AdminDashboardToJson(AdminDashboard instance) =>
    <String, dynamic>{
      'users_count': instance.usersCount,
      'Courses_count': instance.coursesCount,
      'members_count': instance.membersCount,
      'sessions_count': instance.sessionsCount,
    };
