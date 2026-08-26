import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

class MainContainer extends StatelessWidget {
  Widget child;
  double? topMargin;
   MainContainer({required this.child , this.topMargin, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:  EdgeInsets.only(top:topMargin?? 20),
    padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
    width: Get.width,
    height: Get.height,
    decoration: const BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.vertical(top:Radius.circular(50))
    ),
    child: child
    );
  }
}
