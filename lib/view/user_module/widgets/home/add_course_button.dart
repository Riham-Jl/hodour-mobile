import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';

import '../common/empty_button.dart';

class AddCourseButton extends StatelessWidget {
  void Function()? onPressed;
   AddCourseButton({
     required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyButton(
      onPressed: onPressed,
      child: Container(
        width: Get.width*0.16,
        height: Get.width*0.16,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(25)
        ),
        child:  Image.asset(AppImageAsset.whiteAdd),



      ),
    );
  }
}

