import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/auth_controller.dart';

import '../../../../controller/user_module/course/course_controller.dart';
import '../../../../core/constants/routes.dart';
import 'drawer_list_tile.dart';
import 'name_image_widget.dart';


class CourseDrawer extends StatelessWidget {
  const CourseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    CourseController controller = Get.put(CourseController());
    AuthController authController = Get.find();
    return Drawer(
      width: Get.width*0.65,
      backgroundColor: AppColor.primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(top:15 ),
              child: NameImageWidget(
                backgroundImage: AppImageAsset.emptyImage,
                foregroundImage: controller.course!.image,
                title: controller.course!.name,
                description: controller.course!.description??"",
              )
            ),
            Column(
              children: [
                DrawerListTile(
                  onTap: (){
                    controller.closeDrawer();
                    controller.changePage(AppRoute.sessionsPage);
                  },
                  icon: AppImageAsset.hodorBook,
                  title: "attendance_notebook".tr,
                ),
                DrawerListTile(
                  onTap: (){
                    controller.closeDrawer();
                    controller.editCourse();
                  },
                  icon: AppImageAsset.editBlue,
                  title: "edit".tr,
                ),
                DrawerListTile(
                  onTap: (){
                    controller.closeDrawer();
                    controller.changePage(AppRoute.membersPage);
                  },
                  icon: AppImageAsset.membersBlue,
                  title: "members_name".tr,
                ),
                DrawerListTile(
                  onTap: (){
                    controller.closeDrawer();
                    controller.changePage(AppRoute.usersPage);
                  },
                  icon: AppImageAsset.ownersBlue,
                  title: "admins".tr,
                ),
                DrawerListTile(
                  onTap: (){
                    controller.closeDrawer();
                    controller.changePage(AppRoute.resultsPage);
                  },
                  icon: AppImageAsset.results,
                  title: "attendance_results".tr,
                ),
                DrawerListTile(
                  onTap: (){
                    controller.closeDrawer();
                    controller.changePage(AppRoute.absencePage);
                  },
                  icon: AppImageAsset.absents,
                  title: "absences".tr,
                ),

              ],
            ),
            Container(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(bottom: 25  ),
              child: GestureDetector(
                onTap: (){
                  controller.closeDrawer();
                  controller.goToProfile();
                },
                child: NameImageWidget(
                  backgroundImage: AppImageAsset.profile,
                  foregroundImage: authController.user!.image,
                  title: authController.user!.name,
                  description: authController.user!.email,
                  withBorder: true,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
