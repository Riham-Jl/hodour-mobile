import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/core/constants/routes.dart';

import '../../../controller/admin_module/admin_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../user_module/widgets/course/drawer_list_tile.dart';
import '../../user_module/widgets/course/name_image_widget.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Get.find<AdminController>();
    AuthController authController = Get.find();
    return Drawer(
        width: Get.width * 0.68,
        backgroundColor: AppColor.primaryColor,
        child: SafeArea(
            child: Column(
                children: [
              InkWell(
                onTap: (){
                  Get.toNamed(AppRoute.profilePage);
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    margin: const EdgeInsets.only(top: 15),
                    child: NameImageWidget(
                        backgroundImage: AppImageAsset.profile,
                        foregroundImage: authController.user?.image,
                        title: authController.user?.name??"",
                        description: 'System Admin')),
              ),
              const SizedBox(height:80),
              Column(
                  children: [
                DrawerListTile(
                    icon: AppImageAsset.results,
                    title: 'dashboard'.tr,
                    onTap: () => c.changePage(AdminController.dashboardPage)),
                DrawerListTile(
                    icon: AppImageAsset.membersBlue,
                    title: 'users'.tr,
                    onTap: () => c.changePage(AdminController.usersPage)),
                DrawerListTile(
                    icon: AppImageAsset.hodorBook,
                    title: 'courses'.tr,
                    onTap: () => c.changePage(AdminController.coursesPage)),
                DrawerListTile(
                    icon: AppImageAsset.mobile,
                    title: 'mobile_applications'.tr,
                    onTap: () => c.changePage(AdminController.mobileAppsPage))
              ]),

            ])));
  }
}
