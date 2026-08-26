import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

class ResultsHeaderContainer extends StatelessWidget {
  String number;
  String title;
   ResultsHeaderContainer({required this.number , required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width*0.35,
      height: Get.width*0.25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColor.lightGrey,
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
          color: AppColor.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(number , style: const TextStyle(color: AppColor.primaryColor , fontSize: 40 , height: 1),),
          Text(title , style: TextStyle(color: AppColor.secondaryColor , fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
