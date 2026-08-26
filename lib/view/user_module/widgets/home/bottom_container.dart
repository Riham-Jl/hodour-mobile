import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

class HomeBottomContainer extends StatelessWidget {
  bool isLeft;
   HomeBottomContainer({
    required this.isLeft,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isLeft ? EdgeInsets.only(left: Get.width*0.22) : EdgeInsets.zero,
      height: Get.height*0.06,
      width: Get.width*0.39,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.only(topLeft:  Radius.circular(isLeft?50:0) , topRight:  Radius.circular(!isLeft?50:0)),
          color: AppColor.primaryColor
      ),
    );
  }
}