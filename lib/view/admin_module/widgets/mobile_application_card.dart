import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/model/admin/admin_mobile_application.dart';
import 'package:hodor/view/admin_module/widgets/mobile_application_status_extension.dart';

import '../../../controller/admin_module/admin_mobile_applications_controller.dart';
import 'admin_badge.dart';

class MobileApplicationCard extends StatelessWidget {
  final AdminMobileApplication app;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const MobileApplicationCard({
    required this.app,
    required this.onEdit,
    required this.onDelete,
    super.key});


  @override
  Widget build(BuildContext context) {
    final c = Get.find<AdminMobileApplicationsController>();
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(15)),
        child: Row(children: [
          Icon(app.platform == 'android' ? Icons.android : Icons.apple,
              color: AppColor.primaryColor, size: 34),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(app.platform.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: AppColor.darkBlue)),
                Text('${"version".tr} ${app.version}',
                    style: const TextStyle(fontSize: 12, color: AppColor.grey))
              ])),
          AdminBadge(text: app.status.title, color: app.status.color),

          PopupMenuButton<String>(

            onSelected: (value) {

              if(value == 'edit'){
                onEdit();
              }

              if(value == 'delete'){
                onDelete();
              }
            },

            itemBuilder: (context) => [

               PopupMenuItem(
                value: 'edit',
                child: Text('edit'.tr),
              ),

               PopupMenuItem(
                value: 'delete',
                child: Text('delete'.tr),
              ),
            ],
          ),
        ]));
  }
}
