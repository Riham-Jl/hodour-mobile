import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/view/user_module/widgets/common/full_page_loader.dart';

import '../../../controller/admin_module/admin_users_controller.dart';
import '../../../model/admin/admin_user.dart';
import '../../user_module/widgets/common/alert_bottomsheet.dart';
import '../../user_module/widgets/common/custom_button.dart';
import '../../user_module/widgets/common/data_container.dart';
import '../../user_module/widgets/common/empty_button.dart';
import '../../user_module/widgets/common/main_container.dart';
import '../../user_module/widgets/common/search_text_field.dart';
import '../widgets/add_edit_user_dialog.dart';
import '../widgets/admin_user_card.dart';
import '../widgets/admin_user_details_bottomsheet.dart';

class AdminUsersPage extends StatelessWidget {
  const AdminUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminUsersController>(
      builder: (controller) {
        return Stack(
          children: [
            MainContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    spacing: 5,
                    children: [
                      Expanded(
                        child: SearchTextField(
                          searchStatus: controller.searchController.text.isNotEmpty,
                          theController: controller.searchController,
                          onChanged: controller.search,
                          onTapClose: () {
                            controller.searchController.clear();
                            controller.getUsers(refresh: true);
                          },
                        ),
                      ),
                      EmptyButton(
                          onPressed: () {
                            if (!controller.isExporting) {
                              controller.exportUsersExcel();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: AppColor.green
                            ),
                            child: Image.asset(AppImageAsset.importExcel),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: DataContainer(
                      onRefresh: controller.getUsers,
                      isLoading: controller.isLoading,
                      isEmpty: controller.users.isEmpty,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent - 100) {
                            controller.loadMore();
                          }
                          return false;
                        },
                        child: ListView.separated(
                          itemCount: controller.users.length +
                              (controller.isLoadingMore ? 1 : 0),
                          separatorBuilder: (context, index) => Divider(color: AppColor.grey , thickness: 0.2,),
                          itemBuilder: (context, index) {
                            if (index == controller.users.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final user = controller.users[index];

                            return InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  AdminUserDetailsBottomSheet(
                                    user: user,
                                  ),
                                  isScrollControlled: true,
                                );
                              },
                              child: AdminUserCard(
                                user: user,
                                onEdit: () {
                                  _showEditUserDialog(controller, user);
                                },
                                onDelete: () {
                                  _confirmDelete(controller, user);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  CustomButtonWidget(
                      title: 'add_user'.tr,
                      backgroundColor: AppColor.secondaryColor,
                      textColor: AppColor.white,
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPress: () => _showAddUserDialog(controller)),
                ],
              ),
            ),
            if(controller.isExporting)
              FullPageLoader()
          ],
        );
      },
    );
  }
}

Future<void> _showAddUserDialog(
    AdminUsersController controller,
    ) async {
  final result = await Get.dialog<Map<String, dynamic>>(
    const AdminEditUserDialog(
      isEdit: false,
    ),
  );

  if (result != null) {
    await controller.addUser(result);
  }
}

Future<void> _showEditUserDialog(
    AdminUsersController controller,
    AdminUser user,
    ) async {
  final result = await Get.dialog<Map<String, dynamic>>(
    AdminEditUserDialog(
      isEdit: true,
      isAdmin: user.isAdmin,
      allowedCoursesCount: user.allowedCoursesCount,
      allowedMembersCount: user.allowedMembersCount,
    ),
  );

  if (result != null) {
    await controller.updateUser(user, result);
  }
}

void _confirmDelete(
    AdminUsersController controller,
    AdminUser user,
    ) {
  Get.bottomSheet(
    AlertBottomSheet(
      image: AppImageAsset.deleteUser,
      title: 'delete_user'.tr,
      body: "confirm_delete_user".trParams({
        "name":user.name
      }),
      buttonTitle: 'delete'.tr,
      button1Color: AppColor.pink,
      onPress: () async {
        await controller.deleteUser(user);
        Get.back();
      },
    ),
  );
}