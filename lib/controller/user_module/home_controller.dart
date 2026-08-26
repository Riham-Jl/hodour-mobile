import 'dart:io';
import 'package:get/get.dart';
import 'package:hodor/controller/auth_controller.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/core/app_state.dart';
import 'package:hodor/core/constants/app_utils.dart';
import 'package:hodor/core/constants/routes.dart';
import 'package:hodor/core/constants/global_constants.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/course.dart';


import '../../view/user_module/widgets/common/app_version_update_dialog.dart';
import '../../view/user_module/widgets/course/add_course_dialog.dart';
import '../../view/user_module/widgets/course/course_settings.dart';
import 'course/course_controller.dart';
import 'notifications_controller.dart';


class HomeController extends BaseController{
  List<Course> courses=[];
  int pinned=0;


  @override
  void onInit() async{

    AuthController authController = Get.put(AuthController() , permanent: true);

    await authController.getLoggedUser();
    await getCourses();

    super.onInit();
  }

  @override
   onReady() async{
    checkUpdates();
    super.onReady();
  }

  Future<void> getCourses({bool withLoading = true}) async {
    return networkCaller(
      restClient.getCourses(),
      withLoading: withLoading,
    ).then((value) async {
      if (value.status == ResponseStatus.success) {
        courses = value.data;
        courses.sort((a, b) => (b.pinned).compareTo(a.pinned));
        if (courses.isNotEmpty) {
          pinned = courses[0].pinned;
        }
        update();
      } else if (error != null) {
        errorHandling(error!);
      }
    });
  }

  addCourse(){
    Get.dialog( AddEditCourseDialog()).then((value) {
      if(value!=null) {
        add(value['name'] , value['description'] , value['image'] );
      }
    });
  }

    Future add( String name , String? description , String? filePath) async {
      if(filePath!=null){
      File file = File(filePath);
      double fileSize =await (file.length())/ (1024 * 1024);
      if (fileSize <= 2) {
        return networkCaller(
            restClient.addCourseWithImage(name, description, file))
            .then((value) async {
          if (value.status == ResponseStatus.success) {
            getCourses();
          } else if (error != null) {
            errorHandling(error!);
          }
        });
      }
      else {
        Get.rawSnackbar(message: "image_size_validation".tr);
      }

      }
      else {
        return networkCaller(
            restClient.addCourse(name, description))
            .then((value) async {
          if (value.status == ResponseStatus.success) {
            getCourses();
          } else if (error != null) {
            errorHandling(error!);
          }
        });
      }
    }


  goToCourse(Course course){
   CourseController controller =  Get.put(CourseController()  );
   controller.course=course;
    Get.toNamed(AppRoute.coursePage  );
    controller.getSessions();

  }

  openCourseSettings(Course course) {
    Get.bottomSheet(
      CourseSettings(
        course: course,
      ),
    );
  }


    checkUpdates(){
      if (GlobalConstants.isUpgradeMessageNotShown &&
          AppState.appVersionStatus ==
              GlobalConstants.STATUS_VERSION_OPTIONAL_UPDATE) {
        GlobalConstants.isUpgradeMessageNotShown = false;
            Get.dialog(
              barrierDismissible: false,
               AppVersionUpdateDialog(
                    AppUtils.openApplicationStorePage, () {
                  Get.back();
                },
                    false // upgrade optional, so don't exit the app on pressing no
              ));

        }
      }


  goToProfile({bool fromNotifications=false}){
     Get.toNamed(AppRoute.profilePage);
  }

  goToNotification({bool fromProfile=false}){
    NotificationsController nController = Get.find();
    nController.getNotifications();
    Get.toNamed(AppRoute.notificationsPage);
  }

    }





