import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

import 'custom_button.dart';


class AppVersionUpdateDialog extends AlertDialog {
  final void Function() onPositivePressed;
  final void Function() onNegativePressed;
  final bool isForcedUpdate;

  const AppVersionUpdateDialog(
      this.onPositivePressed, this.onNegativePressed, this.isForcedUpdate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
          children: [
      Dialog(
      insetPadding: const EdgeInsets.all(10),
      child:Container(
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(15)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(25 ),
        child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  Text( isForcedUpdate
                    ?"force_update_msg".tr
                    : "optional_update_msg".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColor.darkBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:Get.width*0.25,
                      child: CustomButtonWidget(
                        onPress:  onNegativePressed,

                        title: "no".tr,
                        textColor: AppColor.grey,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width:Get.width*0.25,
                      child: CustomButtonWidget(
                        onPress: onPositivePressed,
                        title:"yes".tr,
                        textColor: AppColor.white,
                        backgroundColor: AppColor.secondaryColor,
                      ),
                    ),
              ],
            ),
          ])),
        )]));
  }
}
