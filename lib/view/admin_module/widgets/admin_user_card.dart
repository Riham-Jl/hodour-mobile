import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/model/admin/admin_user.dart';
import '../../../controller/auth_controller.dart';
import '../../user_module/widgets/common/empty_button.dart';
import 'admin_badge.dart';

class AdminUserCard extends StatelessWidget {
  final AdminUser user;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AdminUserCard({
    required this.user,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    final isCurrentUser =
        authController.user?.id == user.id;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12 , horizontal: 6),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.lightGrey,
            foregroundImage:
            user.image != null ? NetworkImage(user.image!) : null,
            child: user.image == null
                ? const Icon(Icons.person, color: AppColor.primaryColor)
                : null,
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkBlue,
                  ),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.grey,
                  ),
                ),
                Text(
                  '${user.coursesCount}  ${'courses_unit'.tr}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColor.secondaryColor,
                  ),
                ),
              ],
            ),
          ),

          AdminBadge(
            text: isCurrentUser? "me".tr : user.isAdmin ? 'admin'.tr : 'user'.tr,
            color: isCurrentUser
            ? AppColor.green
            :user.isAdmin
                ? AppColor.secondaryColor
                : AppColor.grey,
          ),

          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              } else if (value == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (context) =>  [
              PopupMenuItem(
                value: 'edit',
                child: Text('edit'.tr),
              ),
              if(!isCurrentUser)
              PopupMenuItem(
                value: 'delete',
                child: Text('delete'.tr),
              ),
            ],
            icon: const Icon(
              Icons.more_vert,
              color: AppColor.grey,
            ),
          ),
        ],
      ),
    );
  }
}