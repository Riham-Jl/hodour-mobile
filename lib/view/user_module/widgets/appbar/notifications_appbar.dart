import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/user_module/notifications_controller.dart';

import '../../../../core/constants/images.dart';


class NotificationsAppBarWidget extends StatelessWidget {
  const NotificationsAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(builder: (nController) {
      return Badge(
          isLabelVisible: nController.nonReadNotification>0?true:false,
          label: Text("${nController.nonReadNotification}",),
          child:SizedBox(
              width: double.infinity,
              child: Image.asset(AppImageAsset.notification))
      );});
  }
}
