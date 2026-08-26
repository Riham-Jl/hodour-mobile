
import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/controller/user_module/home_controller.dart';
import 'package:hodor/core/functions/message_toast.dart';

import 'package:hodor/model/notification.dart';
import 'package:hodor/model/response_status.dart';

import '../../core/constants/routes.dart';
import '../../view/user_module/widgets/common/alert_bottomsheet.dart';
import 'course/course_controller.dart';


class NotificationsController extends BaseController{

   List<MyNotification> notifications=[];

   int selectedNotification = -1;


   int nonReadNotification =0;



  @override
  void onInit() async{
    getNotifications();
    super.onInit();
  }

   Future<void> getNotifications(){
    return networkCaller(
        restClient.getNotifications())
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        notifications = value.data;
        nonReadNotification = notifications.where((element) => element.is_read==0).length;
        AppBadgePlus.updateBadge(nonReadNotification);
        update();
      }
      else if (error != null) {
        errorHandling(error!);
      }

    });
  }

   markAsRead(int notificationId , int index ){
     MyNotification notfication = notifications.firstWhere((element) => element.id==notificationId);
    selectedNotification= selectedNotification==index?-1:index;
    update();
     if(notfication.is_read==0) {
       return networkCaller(
           restClient.readNotification(notificationId) , withLoading: false)
           .then((value) async {
         if (value.status == ResponseStatus.success) {
           notifications
               .firstWhere((element) => element.id == notificationId)
               .is_read = 1;
           nonReadNotification -= 1;
         //  selectedNotification = index;
           update();
           AppBadgePlus.updateBadge(nonReadNotification);
         }
         else if (error != null) {
           errorHandling(error!);
         }
       });
     }

   }

   answerInvitation(int courseId , int approve){
    update();
     return networkCaller(
         restClient.answerInvitation(courseId , approve) , withLoading: false)
         .then((value) async {
           Get.back();
       if (value.status == ResponseStatus.success) {
         notifications.removeWhere((element) => element.course_id==courseId && element.type==NotificationType.invitation);
         update();
         showMessageInToast(approve==1? "invitation_accepted".tr:"invitation_rejected".tr);
         HomeController homeController = Get.put(HomeController());
         homeController.getCourses();
       }
       else if (error != null) {
         errorHandling(error!);
       }

     });
   }

   showInvitation(int notificationId  ){
     MyNotification notification = notifications.firstWhere((element) => element.id==notificationId);
    Get.bottomSheet(AlertBottomSheet(
        image: AppImageAsset.invitation,
        title: notification.title,
        body: notification.body!,
        buttonTitle: "accept".tr,
        button1Color: AppColor.secondaryColor,
        button2Title: "reject".tr,

        onPress: (){
          answerInvitation(notification.course_id!, 1);
        },
        onPress2: (){
          answerInvitation(notification.course_id!, 0);
        }
    ),);
   }

   void openNotification(MyNotification notification, int index) async {
     markAsRead(notification.id, index);

     if (notification.type == NotificationType.invitation || notification.type == NotificationType.dropUser){
       return;
     }
     else  {
       if (notification.course_id == null) return;

       CourseController controller = Get.put(CourseController());
       await controller.getCourse(notification.course_id!);

       if (controller.course != null) {
         Get.toNamed(AppRoute.coursePage);
         controller.changePage(AppRoute.usersPage);
       }
     }
   }





   onPop(bool s){
     selectedNotification=-1;
     return true;
   }

   goToProfile({bool fromNotifications=false}){
     Get.offNamed(AppRoute.profilePage);
   }


}