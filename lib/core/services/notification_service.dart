import 'dart:async';
import 'dart:io';
import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/user_module/notifications_controller.dart';

import 'package:hodor/core/constants/routes.dart';
import '../../controller/user_module/course/admins_controller.dart';
import '../../controller/user_module/course/course_controller.dart';
import 'local_notifications_service.dart';
import '../../model/notification.dart';



class FCM {
  void setNotifications() {
    var fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    NotificationService().init();
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, sound: true, badge: true);
    // handle when app in active state
    foregroundNotificationReceived();

    // handle when app running in background state
    backgroundNotificationTapped();

    // handle when app completely closed by the user
     initialMessage();
  }


}

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  AppBadgePlus.updateBadge(
      int.parse(message.data['not_read_notifications_count'])
  );
}

//when click to notification when app is in background:
 void backgroundNotificationTapped()  {
  //print("open message ===============================");
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
     onOpenMessage(message.data ,foreground: false);
    });

  }

//when click to notification when app is terminated:
   initialMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message!=null){
      onOpenMessage(message.data, foreground:false);
  }}

 


// when recieve notification when app is in foreground:
void foregroundNotificationReceived()  {
    FirebaseMessaging.onMessage.listen(
      (message) async {
        final type = NotificationTypeParser.fromString(message.data['type']);
        NotificationsController nController = Get.find();
        await nController.getNotifications();
        if (Get.isRegistered<AdminsController>()) {
          AdminsController controller = Get.find();
          if ((type==NotificationType.answerInvitation ||
              type==NotificationType.withdrawal) && controller.course.id ==
              int.parse(message.data['course_id'])) {
            controller.getUsers();
            // controller.getInvitedUsers();
          }
        }
         if (Get.isRegistered<CourseController>()) {
           CourseController controller = Get.find();
          if (type == NotificationType.dropUser && controller.course!.id ==
              int.parse(message.data['course_id'])) {
            Get.offAllNamed(AppRoute.homePage);
          }
        }
        if (!Platform.isIOS) {
          NotificationService().show(
              message, message.data['course_id'], message.data['type'],
              message.data['notification_id']);
        }
      }


         
    );
  }



//when click to notification:
void onOpenMessage(Map data, {bool foreground = true}) async {
  final type = NotificationTypeParser.fromString(data['type']?.toString());

  if (type == NotificationType.invitation) {
    NotificationsController nController = Get.find();

    if (foreground) {
      nController.showInvitation(int.parse(data['notification_id'].toString()));
    } else {
      await nController.getNotifications();
      nController.showInvitation(int.parse(data['notification_id'].toString()));
    }
  } else if (type == NotificationType.answerInvitation ||
      type == NotificationType.withdrawal) {
    CourseController controller = Get.put(CourseController());

    await controller.getCourse(int.parse(data['course_id'].toString()));

    if (controller.course != null) {
      Get.toNamed(AppRoute.coursePage);
      controller.changePage(AppRoute.usersPage);
    }
  }



    
 
}