import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  void Function()? onTapLeading;
  void Function()? onTapTrailing;
  Widget? leading;
  Widget? trailing;
  String? title;
   MyAppBar({super.key,  this.leading ,  this.onTapLeading , this.trailing , this.onTapTrailing , this.title});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
        automaticallyImplyLeading: false,
        actions: const [SizedBox.shrink()],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onTapLeading,
              child: Container(
                width: Get.width*0.12,
                height: Get.width*0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                    color: title!=null && leading!=null? AppColor.blueWhite.withOpacity(0.2):null
                ),child: leading)
            ),
            title!=null?
                Text(title! , style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),)
                :Image.asset(AppImageAsset.appName , width: Get.width*0.25,),
            GestureDetector(
              onTap: onTapTrailing,
              child: Container(
              width: Get.width*0.12,
              height: Get.width*0.12,
              decoration: trailing!=null? BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.blueWhite.withOpacity(0.2)
              ):null,
              child: trailing,
            ),)
          ],
        ),

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
