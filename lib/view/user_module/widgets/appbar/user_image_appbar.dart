import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/auth_controller.dart';

class UserImageAppBarWidget extends StatelessWidget {
  const UserImageAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AuthController>(builder: (authController) {
      return
        authController.user?.image!=null
            ? ClipRRect(
          borderRadius:  BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: authController.user?.image??"" , fit: BoxFit.fill,
            errorWidget: (context, url, error) => SizedBox(),),
        ):
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColor.lightGrey,),
            child:Image.asset(AppImageAsset.profile, fit: BoxFit.fill,));});
  }
}
