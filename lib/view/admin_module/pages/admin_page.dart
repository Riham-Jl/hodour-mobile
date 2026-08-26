import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hodor/core/constants/images.dart';

import '../../../controller/admin_module/admin_controller.dart';
import '../../../controller/admin_module/admin_courses_controller.dart';
import '../../../controller/admin_module/admin_mobile_applications_controller.dart';
import '../../../controller/admin_module/admin_users_controller.dart';
import '../../user_module/widgets/appbar/app_bar.dart';
import '../../user_module/widgets/common/background_container.dart';
import '../widgets/admin_drawer.dart';
import 'admin_courses_page.dart';
import 'admin_dashboard_page.dart';
import 'admin_mobile_applications_page.dart';
import 'admin_users_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    Get.lazyPut(() => AdminUsersController(), fenix: true);
    Get.lazyPut(() => AdminCoursesController(), fenix: true);
    Get.lazyPut(() => AdminMobileApplicationsController(), fenix: true);
    return GetBuilder<AdminController>(builder: (controller) {
      final pages = {
        AdminController.dashboardPage: const AdminDashboardPage(),
        AdminController.usersPage: const AdminUsersPage(),
        AdminController.coursesPage: const AdminCoursesPage(),
        AdminController.mobileAppsPage: const AdminMobileApplicationsPage(),
      };
      return BackgroundContainer(
        child: Scaffold(
          key: controller.scaffoldKey,
          appBar: MyAppBar(
              title: controller.currentTitle,
              leading: Image.asset(AppImageAsset.drawer),
              onTapLeading: controller.openDrawer),
          drawer: const AdminDrawer(),
          body: SafeArea(
              top: false,
              child: pages[controller.currentPage] ?? const SizedBox()),
        ),
      );
    });
  }
}
