import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/user_module/notifications_controller.dart';

import '../../widgets/appbar/app_bar.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/background_container.dart';
import '../../widgets/common/data_container.dart';
import '../../widgets/common/main_container.dart';
import '../../widgets/common/semi_circular_button_container.dart';
import '../../widgets/notifications/notification_card.dart';


class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsController());
    return  GetBuilder<NotificationsController>(builder: (controller) {
        return BackgroundContainer(
          child:  PopScope(
            onPopInvoked: controller.onPop,
            child: Scaffold(
                appBar: MyAppBar(
                  leading:  AppBackButton(),
                  onTapLeading: () {
                    Get.back();
                  },
                  title: "notifications".tr,
                ),
                body:
                    Stack(
                    children: [
                      MainContainer(
              child: Column(
                children: [
                  const SizedBox(height: 25,),
                  Expanded(
                    child: DataContainer(
                      onRefresh: controller.getNotifications,
                      isLoading:controller.isLoading,
                          isEmpty:controller.notifications.isEmpty,
                        child:  ListView(
                        shrinkWrap: true,
                        children: List.generate( controller.notifications.length, (index) {
                          return  NotificationCard(
                            notification: controller.notifications[index],
                            index: index,
                          );
                        }),

                                    )
                    ),
                  )

                ],
              ),
            ),


                    ],
                  )),
          ));});


  }
}


