
import 'package:json_annotation/json_annotation.dart';

part 'admin_dashboard.g.dart';

@JsonSerializable()
class AdminDashboard {
  @JsonKey(name: 'users_count')
  final int usersCount;

  @JsonKey(name: 'Courses_count')
  final int coursesCount;

  @JsonKey(name: 'members_count')
  final int membersCount;

  @JsonKey(name: 'sessions_count')
  final int sessionsCount;

  AdminDashboard({
    required this.usersCount,
    required this.coursesCount,
    required this.membersCount,
    required this.sessionsCount,
  });

  factory AdminDashboard.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDashboardToJson(this);
}