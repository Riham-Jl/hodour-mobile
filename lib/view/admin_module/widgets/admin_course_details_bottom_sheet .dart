import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/model/admin/admin_course.dart';

class AdminCourseDetailsBottomSheet extends StatelessWidget {

  final AdminCourse course;

  const AdminCourseDetailsBottomSheet({
    required this.course,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: Get.height * 0.78,
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

            /// TOP BAR
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

            /// HEADER
            Row(
              children: [

                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColor.lightGrey,
                  foregroundImage:
                  course.image != null
                      ? NetworkImage(course.image!)
                      : null,
                  child: course.image == null
                      ? const Icon(
                    Icons.menu_book,
                    color: AppColor.primaryColor,
                    size: 28,
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
                        course.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.darkBlue,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                            course.description??"",
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

            const SizedBox(height: 28),

            /// STATS
            Row(
              children: [

                Expanded(
                  child: _InfoCard(
                    title: 'members'.tr,
                    value: '${course.membersCount}',
                    icon: Icons.groups,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _InfoCard(
                    title: 'sessions'.tr,
                    value: '${course.sessionsCount}',
                    icon: Icons.calendar_month,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [

                Expanded(
                  child: _InfoCard(
                    title: 'admins'.tr,
                    value: '${course.adminsCount}',
                    icon: Icons.admin_panel_settings,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _InfoCard(
                    title: 'owner'.tr,
                    value: course.ownerName ?? '-',
                    icon: Icons.person,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            /// OWNER INFO
             Text(
              "course_owner".tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.darkBlue,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColor.blueWhite,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [

                  const CircleAvatar(
                    backgroundColor: AppColor.white,
                    child: Icon(
                      Icons.person,
                      color: AppColor.primaryColor,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          course.ownerName ?? '-',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.darkBlue,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          course.ownerEmail ?? '-',
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
            ),

            const SizedBox(height: 28),

            /// ADMINS
             Text(
              "course_supervisors".tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.darkBlue,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 14),

            if(course.users==null || course.users!.length<=1)
               Text(
               "no_supervisors".tr,
                style: TextStyle(
                  color: AppColor.grey,
                ),
              ),

            ...course.users!
                .skip(1)
                .map(
                  (user) => Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColor.lightGrey,
                  ),
                ),
                child: Row(
                  children: [

                    const CircleAvatar(
                      radius: 18,
                      backgroundColor:
                      AppColor.blueWhite,
                      child: Icon(
                        Icons.person,
                        color:
                        AppColor.primaryColor,
                        size: 18,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            user.name,
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color:
                              AppColor.darkBlue,
                            ),
                          ),

                          Text(
                            user.email,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColor.grey,
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;

  const _InfoCard({
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
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