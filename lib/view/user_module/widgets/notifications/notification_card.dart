import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/user_module/notifications_controller.dart';
import 'package:hodor/core/functions/set_notification_time.dart';
import 'package:hodor/model/notification.dart';

import '../common/empty_button.dart';
import 'invitation_container.dart';


class NotificationCard extends StatelessWidget {
  MyNotification notification;
  int index;
  NotificationCard({
    required this.index,
    required this.notification,
    super.key,
  });

  NotificationsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final bool isRead = notification.is_read==1;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isRead ? AppColor.white : AppColor.lightGrey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isRead ? AppColor.lightGrey : AppColor.primaryColor.withOpacity(0.4),
        ),
      ),
      child: Column(
        children: [
          EmptyButton(
            onPressed: (){
              controller.openNotification(notification, index);
            },
              padding: 10,
          //  color:?AppColor.white:AppColor.lightGrey,
            child:Row(
              spacing: 6,
              children: [
                if (!isRead)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),

                Image.asset(AppImageAsset.notificationGrey),

                Expanded(
                  child: Text(
                    notification.body ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
                      color: isRead ? AppColor.grey : Colors.black,
                    ),
                  ),
                ),

                Text(
                  setNotificationTime(notification.notificationTime),
                  style: const TextStyle(fontSize: 10, color: AppColor.grey),
                ),
              ],
            )
          ),
          if(controller.selectedNotification == index && notification.type==NotificationType.invitation)
            InvitationContainer(controller: controller, notification: notification)
        ],
      ),
    );
  }
}

