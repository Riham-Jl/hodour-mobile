import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/model/admin/admin_user.dart';

class AdminUserDetailsBottomSheet extends StatelessWidget {

  final AdminUser user;

  const AdminUserDetailsBottomSheet({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: Get.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColor.lightGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [

                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColor.lightGrey,
                  foregroundImage:
                  user.image != null
                      ? NetworkImage(user.image!)
                      : null,
                  child: user.image == null
                      ? const Icon(
                    Icons.person,
                    color: AppColor.primaryColor,
                  )
                      : null,
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: AppColor.darkBlue,
                        ),
                      ),

                      Text(
                        user.email,
                        style: const TextStyle(
                          color: AppColor.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              children: [

                Expanded(
                  child: _InfoBox(
                    title: 'courses'.tr,
                    value: '${user.coursesCount}',
                    icon: Icons.menu_book,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _InfoBox(
                    title: 'allowed_courses_count'.tr,
                    value: '${user.allowedCoursesCount}',
                    icon: Icons.lock_open,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [

                Expanded(
                  child: _InfoBox(
                    title: "allowed_members_count".tr,
                    value:
                    '${user.allowedMembersCount}',
                    icon: Icons.groups,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _InfoBox(
                    title: 'type'.tr,
                    value: user.isAdmin
                        ? 'admin'.tr
                        : 'user'.tr,
                    icon: Icons.admin_panel_settings,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

             Text(
              'courses'.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.darkBlue,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 14),

            if(user.courses==null || user.courses!.isEmpty)
               Text(
                'no_courses'.tr,
                style: TextStyle(
                  color: AppColor.grey,
                ),
              ),

            ...user.courses!.map(
                  (course) => Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColor.blueWhite,
                  borderRadius:
                  BorderRadius.circular(16),
                ),
                child: Row(
                  children: [

                    const Icon(
                      Icons.menu_book,
                      color: AppColor.primaryColor,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        course.name,
                        style: const TextStyle(
                          color: AppColor.darkBlue,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;

  const _InfoBox({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.blueWhite,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [

          Icon(
            icon,
            color: AppColor.primaryColor,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.darkBlue,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: AppColor.grey,
            ),
          ),
        ],
      ),
    );
  }
}