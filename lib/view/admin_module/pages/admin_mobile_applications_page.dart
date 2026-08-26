import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

import '../../../controller/admin_module/admin_mobile_applications_controller.dart';
import '../../../core/constants/images.dart';
import '../../user_module/widgets/common/alert_bottomsheet.dart';
import '../../user_module/widgets/common/custom_button.dart';
import '../../user_module/widgets/common/data_container.dart';
import '../../user_module/widgets/common/main_container.dart';
import '../widgets/add_edit_mobile_application_dialog.dart';
import '../widgets/mobile_application_card.dart';

class AdminMobileApplicationsPage extends StatelessWidget {
  const AdminMobileApplicationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminMobileApplicationsController>(builder: (controller) {
      return MainContainer(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: DataContainer(
                onRefresh: controller.getApplications,
                isLoading: controller.isLoading,
                isEmpty: controller.applications.isEmpty,
                child: ListView.builder(
                    itemCount: controller.applications.length,
                    itemBuilder: (context, index) => MobileApplicationCard(
                      app: controller.applications[index],

                      onEdit: () async {

                        final result = await Get.dialog(
                          AddEditMobileApplicationDialog(
                            isEdit: true,
                            app: controller.applications[index],
                          ),
                        );

                        if(result != null){

                          controller.updateApplication(
                            controller.applications[index],
                            result['platform'],
                            result['version'],
                            result['status'],
                          );
                        }
                      },

                      onDelete: () {

                        Get.bottomSheet(

                          AlertBottomSheet(
                            image: AppImageAsset.delete,
                            title:"delete_version".tr,
                            body:
                            "confirm_delete_version".tr,

                            buttonTitle: 'delete'.tr,

                            button1Color: AppColor.pink,

                            onPress: () async {

                              await controller.deleteApplication(
                                controller.applications[index],
                              );

                              Get.back();
                            },
                          ),
                        );
                      },
                    )))),
        CustomButtonWidget(
            title: 'add_version'.tr,
            backgroundColor: AppColor.secondaryColor,
            textColor: AppColor.white,
            icon: const Icon(Icons.add, color: Colors.white),
          onPress: () async {
            final result = await Get.dialog<Map<String, dynamic>>(
              const AddEditMobileApplicationDialog(),
            );

            if (result != null) {
              await controller.addApplication(
                result['platform'] as String,
                result['version'] as String,
                result['status'] as String,
              );
            }
          },
            ),
      ]));
    });
  }
}
