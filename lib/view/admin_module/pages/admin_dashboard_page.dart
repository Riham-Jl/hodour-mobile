import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

import '../../../controller/admin_module/admin_controller.dart';
import '../../user_module/widgets/common/data_container.dart';
import '../../user_module/widgets/common/main_container.dart';
import '../widgets/admin_stat_card.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(builder: (controller) {
      final d = controller.dashboard;
      return MainContainer(
        child: DataContainer(
          onRefresh: controller.getDashboard,
          isLoading: controller.isLoading,
          isEmpty: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              Center(
                  child: Text('system_overview'.tr,
                      style: const TextStyle(
                          color: AppColor.darkBlue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold))),
              const SizedBox(height: 15),
              GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                  children: [
                    AdminStatCard(
                      onPress: ()=> controller.changePage(AdminController.usersPage),
                        title: 'users'.tr,
                        value: (d?.usersCount ?? 0).toString(),
                        icon: Icons.people),
                    AdminStatCard(
                        onPress: ()=> controller.changePage(AdminController.coursesPage),
                        title: 'courses'.tr,
                        value: (d?.coursesCount ?? 0).toString(),
                        icon: Icons.menu_book),
                    AdminStatCard(
                        onPress: ()=> controller.changePage(AdminController.coursesPage),
                        title: 'members'.tr,
                        value: (d?.membersCount ?? 0).toString(),
                        icon: Icons.groups),
                    AdminStatCard(
                        onPress: ()=> controller.changePage(AdminController.coursesPage),
                        title: 'sessions'.tr,
                        value: (d?.sessionsCount ?? 0).toString(),
                        icon: Icons.date_range),
                  ]),
            ]),
          ),
        ),
      );
    });
  }
}
