import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/core/constants/routes.dart';

import '../../../../controller/user_module/course/course_controller.dart';
import '../../../../model/course.dart';
import '../common/bottom_sheet_container.dart';
import '../common/custom_icon_button.dart';
import '../common/custom_list.dart';


class CourseSettings extends StatelessWidget {
  Course course;

   CourseSettings({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    CourseController controller =  Get.put(CourseController() , permanent: true);
    controller.course=course;

    return   SafeArea(
      top: false,
      child: BottomSheetContainer(widgets: [
        Text("Course_settings".tr , style: TextStyle(color: AppColor.darkBlue , fontWeight: FontWeight.bold , fontSize: 16),),
        CustomList(
          onTap: (){
            Get.back();
            controller.pin();
          },
            title: SettingsText(text: course.pinned==0?"pin".tr:"unpin".tr ,),
            icons: CustomIconButton(icon: AppImageAsset.fix,)
        ),
        CustomList(
          onTap: (){
            Get.back();
            controller.editCourse(fromHome: true);
          },
            title: SettingsText(text: "edit".tr,),
            icons: CustomIconButton(icon: AppImageAsset.editBlack,)
        ),
        CustomList(
          onTap: (){
            Get.back();
            Get.toNamed(AppRoute.coursePage);
            controller.changePage(AppRoute.membersPage);
          },
            title: SettingsText(text: "members_name".tr,),
            icons: CustomIconButton(icon: AppImageAsset.membersBlack,)
        ),
        CustomList(
          onTap: (){
            Get.back();
            Get.toNamed(AppRoute.coursePage);
            controller.changePage(AppRoute.usersPage);
          },
            title: SettingsText(text: "admins".tr,),
            icons: CustomIconButton(icon: AppImageAsset.ownersBlack,)
        ),
        CustomList(
          onTap: (){
            Get.back();
            controller.deleteCourse(course );
          },
            title: SettingsText(text: course.is_owner? "delete_taffakkud".tr : "leave_Course".tr,),
            icons: CustomIconButton(icon: AppImageAsset.delete,)
        ),
      ]),
    );
  }
}

class SettingsText extends StatelessWidget {
  String text;
   SettingsText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text , style: const TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold),);
  }
}
