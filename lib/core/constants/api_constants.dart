class Api {
  static const String baseUrl = "https://hodour.sparkybee.tech/api";
      //"http://127.0.0.1:8000/api";


  //auth
  static const String loginApi = "/auth/login";
  static const String googleLoginApi = "/auth/login/google";
  static const String signupApi = "/auth/signup";
  static const String logoutApi = "/auth/logout";

  //user
  static const String updateUserApi = "/user/update";
  static const String changeLangApi = "/user/change_language";

  static const String profile = "/user/profile";
  static const String getInvitations = "/user/get_invitations";
  static const String getNotifications = "/notifications";
  static const String readNotification = "/notifications/read/";

  //Courses
  static const String getCourses = "/courses/get_courses";
  static const String getCourse = "/courses/get_course/";
  static const String addCourse = "/courses/create";
  static const String editCourse = "/courses/edit/";
  static const String pinCourse = "/courses/pin/";
  static const String deleteCourse = "/courses/delete/";
  static const String dropCourse = "/courses/drop_course/";
  static const String getUsers = "/courses/get_users/";
  static const String getInvitedUsers = "/courses/get_invited_users/";
  static const String addUser = "/courses/add_user";
  static const String deleteUser = "/courses/delete_user/";
  static const String deleteInvitation = "/courses/delete_invitation/";
  static const String answerInvitation = "/courses/answer_invitation/";




  //members
  static const String getMembers = "/members/get/";
  static const String addMembers = "/members/import";
  static const String addMember = "/members/add";
  static const String editMember = "/members/edit/";
  static const String deleteMember = "/members/delete/";


  //Sessions
  static const String getSessions = "/sessions/get/";
  static const String addSession = "/sessions/add";
  static const String editSession = "/sessions/edit/";
  static const String deleteSession = "/sessions/delete/";

  //Attendance
  static const String sendAttendance = "/attendance/add";

  static const String attendanceResult = "/attendance/get_result";
  static const String sessionResult = "/attendance/get_session_attendance";
  static const String memberResult = "/attendance/get_member_attendance";
  static const String attendanceResultExcel = "/attendance/get_result";
  static const String sessionResultExcel = "/attendance/get_session_attendance";
  static const String memberResultExcel = "/attendance/get_member_attendance";
  static const String recurrentAbsences = "/attendance/get_recurrent_absences/";

  // {{thaber_base_url}}/T_{{thaber_mobile_tenant}}/api/auth/logout
  static const String activeExamsApi = "api/exams/active";
  static const String previousExamsApi = "api/exams/finished";
  static const String examDetailsApi = "api/exams/";

  static const String profileApi = "api/profile";
  static const String updateProfileApi = "api/profile?_method=PUT";
  static const String changePasswordApi = "api/profile?_method=PUT";
  static const String changePhoneApi = "api/profile?_method=PUT";
  static const String updateProfilePhotoApi = "api/profile?_method=PUT";
  static const String startExamAPi = "api/exams/start/";
  static const String closeExamAPi = "api/exams/submit/";
  static const String questionsApi = "api/exams/questions/";
  static const String sendAnswerApi = "api/questions/submit_answer/";
  static const String deleteAnswerApi = "api/questions/delete_answer/";
  static const String addFlaggedApi = "api/questions/add_flag/";
  static const String removeFlaggedApi = "api/questions/remove_flag/";
  static const String notificationsApi = "api/myNotifications";




  // Admin
  static const String adminLogin = "/admin/login";
  static const String adminLogout = "/admin/logout";
  static const String adminDashboard = "/admin/dashboard";

  static const String adminUsers = "/admin/users";
  static const String adminUserInfo = "/admin/users/user_info/";
  static const String adminDeleteUser = "/admin/users/";
  static const String adminTrashedUsers = "/admin/trashed_users";
  static const String adminRestoreUser = "/admin/trashed_users/";

  static const String adminCourses = "/admin/Courses";
  static const String adminDeleteCourse = "/admin/Courses/";
  static const String adminCourseUsers = "/admin/Courses/get_users/";
  static const String adminCourseMembers = "/admin/Courses/get_members/";
  static const String adminCourseSessions = "/admin/Courses/get_Sessions/";

  static const String adminMobileApplications = "/admin/mobile_applications";
  static const String adminDeleteMobileApplication = "/admin/mobile_applications/";


  static const int pageSize = 15;

  static const String deleteProfilePhotoApi = "api/profile?_method=PUT";
}