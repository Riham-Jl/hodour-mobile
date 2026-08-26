import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

class AuthSwitchWidget extends StatelessWidget {
  const AuthSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: Get.width*0.35, child: const Divider(color: Colors.white,)),
        Text("or".tr , style: TextStyle(color: AppColor.white , fontSize: 12),),
        SizedBox(width: Get.width*0.35, child: const Divider(color: Colors.white,))
      ],
    );
  }
}
