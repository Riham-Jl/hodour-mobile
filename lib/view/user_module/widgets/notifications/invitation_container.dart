import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/controller/user_module/notifications_controller.dart';
import 'package:hodor/model/notification.dart';

import '../common/custom_button.dart';

class InvitationContainer extends StatefulWidget {
   InvitationContainer({
    super.key,
    required this.controller,
    required this.notification,
  });

  final NotificationsController controller;
  final MyNotification notification;

  @override
  State<InvitationContainer> createState() => _InvitationContainerState();
}

class _InvitationContainerState extends State<InvitationContainer> {
  Widget? button1Icon;

  Widget? button2Icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            width: Get.width*0.3 ,
            child: CustomButtonWidget(
                title: "accept".tr,
                fontSize: 12,
                icon: button1Icon,
                backgroundColor: AppColor.secondaryColor,
                textColor: AppColor.white,
                onPress: (){
                  setState(() {
                    button1Icon=const SizedBox(width:15, height:15, child: CircularProgressIndicator());
                  });
                  widget.controller.answerInvitation(widget.notification.course_id!, 1);
                })
        ),
        SizedBox(
            width: Get.width*0.3 ,
            child: CustomButtonWidget(
                title: "reject".tr,
                fontSize: 12,
                icon:  button2Icon,
                backgroundColor: AppColor.pink,
                textColor: AppColor.white,

                onPress: (){
                  setState(() {
                    button2Icon=const SizedBox(width:15, height:15, child: CircularProgressIndicator());
                  });
                  widget.controller.answerInvitation(widget.notification.course_id!, 0);

                })
        ),
      ],);
  }
}