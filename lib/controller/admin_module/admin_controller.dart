import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/core/constants/routes.dart';
import 'package:hodor/model/admin/admin_dashboard.dart';
import 'package:hodor/model/response_status.dart';

import '../auth_controller.dart';

class AdminController extends BaseController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const dashboardPage = 'admin_dashboard';
  static const usersPage = 'admin_users';
  static const coursesPage = 'admin_courses';
  static const mobileAppsPage = 'admin_mobile_apps';

  String currentPage = dashboardPage;
  AdminDashboard? dashboard;

  String get currentTitle {
    switch (currentPage) {
      case usersPage:
        return 'users'.tr;
      case coursesPage:
        return 'courses'.tr;
      case mobileAppsPage:
        return 'mobile_applications'.tr;
      default:
        return 'dashboard'.tr;
    }
  }

  @override
  void onInit() async {
    AuthController authController = Get.put(AuthController() , permanent: true);

    await authController.getLoggedUser();
    getDashboard();
    super.onInit();
  }

  void openDrawer() => scaffoldKey.currentState?.openDrawer();
  void changePage(String page) {
    currentPage = page;
    if (scaffoldKey.currentState?.isDrawerOpen ?? false) Get.back();
    update();
  }

  Future<void> getDashboard() {
    return networkCaller(restClient.adminDashboard()).then((value) {
      if (value.status == ResponseStatus.success) {
        dashboard = value.data is AdminDashboard
            ? value.data
            : AdminDashboard.fromJson(value.data);
        update();
      } else if (error != null) {
        errorHandling(error!);
      }
    });
  }


}
