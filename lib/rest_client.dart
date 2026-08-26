import 'dart:io';

import 'package:hodor/core/constants/api_constants.dart';
import 'package:hodor/model/admin/admin_course.dart';
import 'package:hodor/model/session_attendance.dart';
import 'package:hodor/model/member.dart';
import 'package:hodor/model/session.dart';
import 'package:hodor/model/member_attendance.dart';
import 'package:hodor/model/recurrent_absent.dart';
import 'package:hodor/model/response_model.dart';
import 'package:hodor/model/send_attendance_request.dart';
import 'package:hodor/model/send_session_request.dart';
import 'package:hodor/model/send_members_request.dart';
import 'package:hodor/model/course.dart';
import 'package:hodor/model/course_result.dart';
import 'package:hodor/model/course_user.dart';
import 'package:hodor/model/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'model/admin/admin_mobile_application.dart';
import 'model/admin/admin_user.dart';
import 'model/notification.dart';
import 'model/paginated_response.dart';



part 'rest_client.g.dart';

@RestApi(baseUrl: Api.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;


  // ================================= User Management APIs

  @POST(Api.loginApi)
  Future<ResponseModel<User>> login( @Field("email") String email , @Field("password") String password , @Field("fcm_token") String? fcmToken) ;

  @POST(Api.googleLoginApi)
  Future<ResponseModel<User>> googleLogin(
      @Field("id_token") String idToken,
      @Field("platform") String platform,
      @Field("fcm_token") String? fcmToken,
      );
  @POST(Api.signupApi)
  Future<ResponseModel<User>> signup(@Field("name") String name , @Field("email") String email , @Field("password") String password , @Field("fcm_token") String? fcmToken , @Field("language") String? language) ;

  @POST(Api.updateUserApi)
  Future<ResponseModel<User>> updateUser(@Field("name") String? name , @Field("old_password") String? oldPassword , @Field("new_password") String? newPassword , ) ;

  @POST(Api.updateUserApi)
  Future<ResponseModel<User>> updateUserImage( @Part(name:"image") File image  ) ;

  @POST(Api.updateUserApi)
  Future<ResponseModel<User>> deleteUserImage(   @Field("delete_image") bool deleteImage ) ;

  @GET(Api.profile)
  Future<ResponseModel<User>> getProfile() ;

  @POST(Api.changeLangApi)
  Future<ResponseModel> changeLanguage(   @Field("language") String language ) ;


  @GET(Api.logoutApi)
  Future<ResponseModel> logout() ;

  // @GET(Api.getInvitations)
  // Future<ResponseModel<List<Invitation>>> getInvitations() ;

  @GET(Api.getNotifications)
  Future<ResponseModel<List<MyNotification>>> getNotifications();

  @GET(Api.readNotification+"{notification_id}")
  Future<ResponseModel> readNotification(@Path("notification_id") int notificationId  )  ;


  // ================================= Courses APIs
  @GET(Api.getCourses)
  Future<ResponseModel<List<Course>>> getCourses() ;

  @POST(Api.addCourse)
  @MultiPart()
  Future<ResponseModel<Course>> addCourseWithImage(@Part(name:"name") String name , @Part(name:"description") String? description , @Part(name:"image") File image) ;

  @POST(Api.addCourse)
  Future<ResponseModel<Course>> addCourse(@Part(name:"name") String name , @Part(name:"description") String? description ) ;

  @GET(Api.getCourse+"{course_id}")
  Future<ResponseModel<Course>> getCourse(@Path("course_id") int courseId) ;

  @POST(Api.editCourse+"{course_id}?_method=PUT")
  Future<ResponseModel<Course>> editCourseWithImage(@Path("course_id") int courseId ,@Part(name:"name" ) String name , @Part(name:"description") String? description  , @Part(name:"image") File image ) ;

  @POST(Api.editCourse+"{course_id}?_method=PUT")
  Future<ResponseModel<Course>> editCourse(@Path("course_id") int courseId ,@Field( "name" ) String name , @Field("description") String? description , @Field("delete_image") bool? deleteImage  ) ;

  @GET(Api.pinCourse+"{course_id}/{pin}")
  Future<ResponseModel> pinCourse(@Path("course_id") int courseId , @Path("pin") int pin) ;

  @DELETE(Api.deleteCourse+"{course_id}")
  Future<ResponseModel> deleteCourse(@Path("course_id") int courseId ) ;

  @GET(Api.getUsers+"{course_id}")
  Future<ResponseModel<List<CourseUser>>> getUsers(@Path("course_id") int courseId) ;

  // @GET(Api.getInvitedUsers+"{course_id}")
  // Future<ResponseModel<List<CourseUser>>> getInvitedUsers(@Path("course_id") int CourseId) ;

  @POST(Api.addUser)
  Future<ResponseModel> addUser(@Field("course_id") int courseId ,@Field( "email" ) String email  ) ;

  @GET(Api.deleteUser+"{course_id}/{user_id}")
  Future<ResponseModel> deleteUser(@Path("course_id") int courseId , @Path("user_id") int userId )  ;

  @GET(Api.deleteInvitation+"{course_id}/{user_id}")
  Future<ResponseModel> deleteInvitation(@Path("course_id") int courseId , @Path("user_id") int userId )  ;

  @GET(Api.dropCourse+"{course_id}")
  Future<ResponseModel> dropCourse(@Path("course_id") int courseId ) ;

  @GET(Api.answerInvitation+"{course_id}/{approve}")
  Future<ResponseModel> answerInvitation(@Path("course_id") int courseId ,@Path("approve") int approve  ) ;

  @GET(Api.recurrentAbsences+"{course_id}")
  Future<ResponseModel<List<RecurrentAbsent>>> getRecurrentAbsences(@Path("course_id") int courseId ) ;



  // ================================= members APIs
  @GET(Api.getMembers+"{course_id}")
  Future<ResponseModel<List<Member>>> getMembers(@Path("course_id") int courseId) ;

  @POST(Api.addMember)
  Future<ResponseModel<List<Member>>> addMember(@Field("course_id") int courseId ,@Field( "name" ) String name ,@Field( "note" ) String? note ,@Field( "session_id" ) int? sessionId);

  @POST(Api.addMembers)
  Future<ResponseModel<List<Member>>> addMembers(@Body() SendMembersRequest sendMembersRequest);

  @POST(Api.editMember+"{member_id}?_method=PUT")
  Future<ResponseModel<Member>> editMember(@Path("member_id") int memberId , @Field("name") String name ,@Field("note") String? note) ;

  @DELETE(Api.deleteMember+"{member_id}")
  Future<ResponseModel> deleteMember(@Path("member_id") int memberId) ;



  // ================================= Sessions APIs
  @GET(Api.getSessions+"{course_id}")
  Future<ResponseModel<List<Session>>> getSessions(@Path("course_id") int courseId) ;

  @POST(Api.addSession)
  Future<ResponseModel<Session>> addSession(@Body() SendSessionRequest session);

  @POST(Api.editSession+"{session_id}?_method=PUT")
  Future<ResponseModel<Session>> editSession(@Path("session_id") int sessionId , @Body() SendSessionRequest session) ;

  @DELETE(Api.deleteSession+"{session_id}")
  Future<ResponseModel> deleteSession(@Path("session_id") int sessionId) ;


  // ================================= Attendance APIs
  @POST(Api.sendAttendance)
  Future<ResponseModel> sendAttendance(@Body() SendAttendanceRequest sendAttendanceRequest);

  @GET(Api.attendanceResult)
  Future<ResponseModel<List<CourseResult>>> getAttendanceResult(  @Query("course_id") int courseId  ,  @Query("start_Session") String? startSession ,  @Query("end_Session") String? endSession  ) ;

  @GET(Api.attendanceResultExcel)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> getAttendanceResultExcel(  @Query("course_id") int courseId , @Query("start_Session") String? startSession ,  @Query("end_Session") String? endSession , {@Query("excel") bool excel = true }  ) ;

  @GET(Api.sessionResult)
  Future<ResponseModel<List<SessionAttendance>>> getSessionResult(  @Query("course_id") int courseId , @Query("session_id") int sessionId  ) ;

  @GET(Api.sessionResultExcel)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> getSessionResultExcel(  @Query("course_id") int courseId ,@Query("session_id") int sessionId , {@Query("excel") bool excel = true }  ) ;

  @GET(Api.memberResult)
  Future<ResponseModel<List<MemberAttendance>>> getMemberResult(  @Query("course_id") int courseId , @Query("member_id") int memberId , @Query("start_Session") String? startSession ,  @Query("end_Session") String? endSession   ) ;

  @GET(Api.memberResultExcel)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> getMemberResultExcel(  @Query("course_id") int courseId ,@Query("member_id") int memberId ,@Query("start_Session") String? startSession ,  @Query("end_Session") String? endSession , {@Query("excel") bool excel = true }  ) ;



// ================================= ADMIN APIs

// ---------- Dashboard ----------
  @GET(Api.adminDashboard)
  Future<ResponseModel<dynamic>> adminDashboard();


  // ---------- Admin Users ----------
  @GET(Api.adminUsers)
  Future<ResponseModel<PaginatedResponse<AdminUser>>> adminUsers({
    @Query("per_page") int perPage = 15,
    @Query("page") int page = 1,
    @Query("search_query") String? search,
  });

  @POST(Api.adminUsers)
  Future<ResponseModel<AdminUser>> adminAddUser(
      @Body() Map<String, dynamic> body,
      );

  @PUT(Api.adminUsers + "/{id}")
  Future<ResponseModel<AdminUser>> adminUpdateUser(
      @Path("id") int id,
      @Body() Map<String, dynamic> body,
      );

  @DELETE(Api.adminDeleteUser + "{id}")
  Future<ResponseModel> adminDeleteUser(
      @Path("id") int id,
      );

  @GET(Api.adminUsers)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> adminUsersExcel({
    @Query("export") bool export = true,
  });


// ---------- Courses ----------
  @GET(Api.adminCourses)
  Future<ResponseModel<PaginatedResponse<AdminCourse>>> adminCourses({
    @Query("per_page") int perPage = 100,
  });

  @GET(Api.adminCourses)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> adminCoursesExcel({
    @Query("export") bool export = true,
  });


  @DELETE(Api.adminDeleteCourse + "{id}")
  Future<ResponseModel> adminDeleteCourse(
      @Path("id") int id,
      );




// ---------- Mobile Applications ----------
  @GET(Api.adminMobileApplications)
  Future<ResponseModel<PaginatedResponse<AdminMobileApplication>>> adminMobileApplications({
    @Query("per_page") int perPage = 100,
  });

  @POST(Api.adminMobileApplications)
  Future<ResponseModel<dynamic>> adminAddMobileApplication(
      @Body() Map<String, dynamic> body,
      );

  @PUT(Api.adminMobileApplications + "/{id}")
  Future<ResponseModel<dynamic>> adminUpdateMobileApplication(
      @Path("id") int id,
      @Body() Map<String, dynamic> body,
      );

  @DELETE(Api.adminDeleteMobileApplication + "{id}")
  Future<ResponseModel> adminDeleteMobileApplication(
      @Path("id") int id,
      );

  //auth:
  @GET(Api.adminLogout)
  Future<ResponseModel> adminLogout() ;


}
