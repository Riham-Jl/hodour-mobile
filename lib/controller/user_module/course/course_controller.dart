import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/user_module/course/results_controller.dart';
import 'package:hodor/controller/user_module/course/session_controller.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/controller/user_module/home_controller.dart';

import 'package:hodor/core/constants/routes.dart';
import 'package:hodor/core/functions/message_toast.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/course.dart';

import '../../../view/user_module/pages/course/absence_page.dart';
import '../../../view/user_module/pages/course/admins_page.dart' show AdminsPage;
import '../../../view/user_module/pages/course/course_members_import.dart';
import '../../../view/user_module/pages/course/member_results_page.dart';
import '../../../view/user_module/pages/course/members_page.dart';
import '../../../view/user_module/pages/course/results_page.dart';
import '../../../view/user_module/pages/course/sessions_page.dart';
import '../../../view/user_module/widgets/common/alert_bottomsheet.dart';
import '../../../view/user_module/widgets/course/add_course_dialog.dart';
import 'absence_controller.dart';
import 'admins_controller.dart';
import 'import_members_controller.dart';
import 'member_controller.dart';



class CourseController extends BaseController{


  Map<String,Widget> pages =const {
        AppRoute.sessionsPage: SessionsPage(),
        AppRoute.membersPage: MembersPage() ,
        AppRoute.usersPage: AdminsPage() ,
        AppRoute.resultsPage:  ResultsPage() ,
        AppRoute.memberResultsPage: MemberResultsPage() ,
        AppRoute.absencePage: AbsencePage() ,
        AppRoute.importMembersPage: CourseImportPage()
  };

  String currentPage=AppRoute.sessionsPage;


  Course? course;


  HomeController homeController = Get.find();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() async{
    await putCourseControllers();
    if(Get.arguments!=null) course = Get.arguments['Course'];
    super.onInit();
  }

  putCourseControllers(){
    Get.lazyPut(() => SessionController()  ,fenix: true);
    Get.lazyPut(() => MemberController() , fenix: true );
    Get.lazyPut(() => AdminsController() , fenix: true);
    Get.lazyPut(() => ResultsController() , fenix: true);
    Get.lazyPut(() => AbsenceController() , fenix: true);
    Get.lazyPut(() => ImportMembersController() , fenix: true);
  }

  getSessions({bool withLoading = true}){
    SessionController sessionController = Get.find();
    sessionController.getSessions(withLoading: withLoading);
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.closeEndDrawer();
  }

  changePage(String page ) {
    if (currentPage != page) {
      switch(page){
        case AppRoute.sessionsPage:
          getSessions(withLoading: false);
          break;
        case AppRoute.membersPage:
          MemberController controller = Get.find();
          controller.getMembers(null);
          break;
        case AppRoute.usersPage:
          AdminsController controller = Get.find();
          controller.getUsers();
        //  controller.getInvitedUsers();
          break;
        case AppRoute.resultsPage:
          ResultsController controller = Get.find();
          controller.getCourseResults();
          break;
        case AppRoute.absencePage:
          AbsenceController controller = Get.find();
          controller.getRecurrentAbsences();
          break;
      }
       currentPage = page;
        update();
    }
  }



   editCourse({bool fromHome=false}){
     Get.dialog( AddEditCourseDialog(
       isEdit: true,
       initName: course!.name,
       initDescription: course!.description??"",
       image: course!.image,
     )).then((value) {
       if(value!=null) {
         edit(value['name'] , value['description'] , value['image'] , value ['delete_image'] , fromHome);
       }
     });

   }


  Future edit( String name , String? description , String? filePath , bool? delete_image , bool fromHome) async{
    if(filePath!=null){
      File file = File(filePath);
      double fileSize =await (file.length())/1024/1024;
      if (fileSize <= 2) {
    return networkCaller(
        restClient.editCourseWithImage(course!.id , name , description , file))
        .then((value) async {
          afterEdit(value , fromHome);
    });
  }
      else {
        Get.rawSnackbar(message: "image_size_validation".tr);
      }
    }
    else {
      return networkCaller(
          restClient.editCourse(course!.id , name , description ,delete_image))
          .then((value) async {
        afterEdit(value , fromHome);
      });
    }

  }

  afterEdit(value , bool fromHome) async{
    if (value.status == ResponseStatus.success) {
      showMessageInToast("edited_successfully".tr);
      if(fromHome) {
        await homeController.getCourses();
        course =
            homeController.courses.firstWhere((element) => element.id ==
                course!.id);
      }
      else {
        course= value.data;
      }
      update();

    }else if (error != null) {
      errorHandling(error!);
    }
  }

   deleteCourse(Course course){
     Get.bottomSheet(
       AlertBottomSheet(
         image: AppImageAsset.deleteTafakkud,
         title: course.is_owner? "delete_taffakkud".tr:"leave_Course".tr,
         body: "confirm_delete_leave_Course".trParams({
           "Course": course.name,
           "action": course.is_owner? "delete".tr : "leave".tr
         }),
         buttonTitle: course.is_owner? "delete".tr : "leave".tr,

         onPress: (){
           delete(course);
         }
       )
     );
   }


   Future delete(Course course ) async{
     return networkCaller(
         course.is_owner? restClient.deleteCourse(course.id):restClient.dropCourse(course.id))
         .then((value) async {
       Get.back();
       if (value.status == ResponseStatus.success) {
         showMessageInToast("deleted_successfully".tr);
         homeController.courses.removeWhere((item) => item == course);
         homeController.update();
       }else if (error != null) {
         errorHandling(error!);
       }
     });
   }

   Future pin() async{
     return networkCaller(
        restClient.pinCourse(course!.id , course!.pinned==0?homeController.pinned+1:0))
         .then((value) async {
       if (value.status == ResponseStatus.success) {
         showMessageInToast( course!.pinned==0?"pinned_successfully".tr:"unpinned_successfully".tr);
         homeController.getCourses();
       }else if (error != null) {
         errorHandling(error!);
       }
     });
   }



  goToProfile(){
    Get.toNamed(AppRoute.profilePage);
  }



  onPop(bool s){
      Future.delayed(const Duration(milliseconds: 0), () {
        Get.delete<CourseController>(force: true);
        homeController.getCourses(withLoading: false);
      });

    return true;
    }



    getCourse(int id){
      return networkCaller(
          restClient.getCourse(id))
          .then((value) async {
        if (value.status == ResponseStatus.success) {
          course = value.data;
          update();
        }
        else if (error != null) {
          errorHandling(error!);
        }

      });
    }
  }
