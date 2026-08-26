import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/box_shadow.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../controller/user_module/course/member_results_controller.dart';
import '../../../../core/constants/colors.dart';


class MemberResultHeader extends StatelessWidget {
   MemberResultHeader({
    super.key,
  });

   MemberResultsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:  20),
      width: Get.width,
      height: Get.width*0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            buildBoxShadow()
          ],
          color: AppColor.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.memberName , style: const TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold , fontSize: 16 , height: 2),),
               Text( "attendance_days_count".tr, style: TextStyle(fontSize: 12 , color: AppColor.grey , fontWeight: FontWeight.bold , height: 2),),
              Text("${controller.attendance}/${controller.allDays}", style: const TextStyle(fontSize: 14 , color: AppColor.secondaryColor , fontWeight: FontWeight.bold , height: 2),)
            ],
          ),
          CircularPercentIndicator(
            animation: true,
            radius: 40.0,
            lineWidth: 8.0,
            percent:controller.percentageNum/100,
            center:  Text("${controller.percentage}%" , style: TextStyle(color: controller.percentageNum<50? AppColor.pink:AppColor.secondaryColor , fontWeight: FontWeight.bold),),
            progressColor: controller.percentageNum<50? AppColor.pink:AppColor.secondaryColor,
            backgroundColor: AppColor.lightGrey,
          ),


        ],
      ),
    );
  }
}

