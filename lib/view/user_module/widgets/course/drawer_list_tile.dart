import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

import '../common/custom_icon_button.dart';

class DrawerListTile extends StatelessWidget {
  String icon;
  String title;
  void Function()? onTap;
   DrawerListTile({required this.icon ,required this.title, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return    GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 0.5),
        padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 15),
        width: Get.width,
        color: AppColor.darkBlue,
        child: (
            Row(
              children: [
                CustomIconButton(
                    color: AppColor.primaryColor.withOpacity(0.6),
                    icon:icon),
                const SizedBox(width: 3,),
                Text(title , style: const TextStyle(color: AppColor.white , fontWeight: FontWeight.bold),)
              ],
            )
        ),
      ),
    );
  }
}
