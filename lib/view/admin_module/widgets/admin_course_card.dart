import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/model/admin/admin_course.dart';


class AdminCourseCard extends StatelessWidget {
  final AdminCourse course;
  final VoidCallback onDelete;

  const AdminCourseCard({
    required this.course,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.lightGrey,
            foregroundImage:
            course.image != null ? NetworkImage(course.image!) : null,
            child: course.image == null
                ? const Icon(
              Icons.menu_book,
              color: AppColor.primaryColor,
            )
                : null,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkBlue,
                  ),
                ),

                Text(
                  '${"members".tr}: ${course.membersCount}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.grey,
                  ),
                ),

                Text(
                  '${"sessions".tr}: ${course.sessionsCount}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColor.secondaryColor,
                  ),
                ),
              ],
            ),
          ),

          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (_) =>  [
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