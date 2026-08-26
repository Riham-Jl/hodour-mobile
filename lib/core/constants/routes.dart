import 'package:get/get.dart';
import 'package:hodor/core/services/middleware.dart';

import '../../view/admin_module/pages/admin_page.dart';
import '../../view/user_module/pages/auth/login_page.dart';
import '../../view/user_module/pages/auth/signup_page.dart';
import '../../view/user_module/pages/course/absence_page.dart';
import '../../view/user_module/pages/course/admins_page.dart';
import '../../view/user_module/pages/course/attendance_page.dart';
import '../../view/user_module/pages/course/course_page.dart';
import '../../view/user_module/pages/course/member_results_page.dart';
import '../../view/user_module/pages/course/members_import_page.dart';
import '../../view/user_module/pages/course/members_page.dart';
import '../../view/user_module/pages/course/results_page.dart';
import '../../view/user_module/pages/course/sessions_page.dart';
import '../../view/user_module/pages/home_page.dart';
import '../../view/user_module/pages/user/notifications_page.dart';
import '../../view/user_module/pages/user/profile_page.dart';




List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => const LoginPage() , middlewares: [AuthMiddleWare()]),
  GetPage(name: AppRoute.loginPage, page: () => const LoginPage()),
  GetPage(name: AppRoute.signUpPage, page: () => const SignUpPage()),
  GetPage(name: AppRoute.profilePage, page: () => const ProfilePage()),
  GetPage(name: AppRoute.homePage, page: () => const HomePage()),
  GetPage(name: AppRoute.coursePage, page: () => const CoursePage()),
  GetPage(name: AppRoute.usersPage, page: () => const AdminsPage()),
  GetPage(name: AppRoute.membersPage, page: () => const MembersPage()),
  GetPage(name: AppRoute.sessionsPage, page: () => const SessionsPage()),
  GetPage(name: AppRoute.attendancePage, page: () => const AttendancePage()),
  GetPage(name: AppRoute.resultsPage, page: () => const ResultsPage()),
  GetPage(name: AppRoute.memberResultsPage, page: ()=> const MemberResultsPage()),
  GetPage(name: AppRoute.absencePage, page: ()=> const AbsencePage()),
  GetPage(name: AppRoute.importMembersPage, page: ()=> const MembersImportPage()),
  GetPage(name: AppRoute.notificationsPage, page: ()=> const NotificationsPage()),
  GetPage(name: AppRoute.adminPage, page: ()=> const AdminPage())




];

class AppRoute {
  static const String signUpPage = "/signupPage";
  static const String loginPage = "/loginPage";
  static const String profilePage = "/profilePage";
  static const String homePage = "/homePage";
  static const String coursePage = "/coursePage";
  static const String usersPage = "/usersPage";
  static const String sessionsPage = "/sessionsPage";
  static const String membersPage = "/membersPage";
  static const String attendancePage = "/attendancePage";
  static const String resultsPage = "/resultsPage";
  static const String memberResultsPage = "/memberResultsPage";
  static const String absencePage = "/absencePage";
  static const String importMembersPage = "/importMembersPage";
  static const String notificationsPage = "/notificationsPage";
  static const String adminPage = "/adminPage";


}
