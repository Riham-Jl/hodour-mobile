import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/model/admin/admin_course.dart';
import 'package:hodor/view/admin_module/widgets/admin_course_details_bottom_sheet%20.dart';
import 'package:hodor/view/user_module/widgets/common/full_page_loader.dart';

import '../../../controller/admin_module/admin_courses_controller.dart';
import '../../../model/course.dart';
import '../../user_module/widgets/common/alert_bottomsheet.dart';
import '../../user_module/widgets/common/data_container.dart';
import '../../user_module/widgets/common/empty_button.dart';
import '../../user_module/widgets/common/main_container.dart';
import '../../user_module/widgets/common/search_text_field.dart';
import '../widgets/admin_course_card.dart';

class AdminCoursesPage extends StatelessWidget {
  const AdminCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminCoursesController>(
      builder: (controller) {
        return Stack(
          children: [
            MainContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  Row(
                    spacing: 5,
                    children: [
                      Expanded(
                        child: SearchTextField(
                          searchStatus:
                          controller.searchController.text.isNotEmpty,
                          theController: controller.searchController,
                          onChanged: controller.search,
                          onTapClose: () {
                            controller.searchController.clear();
                            controller.getCourses(refresh: true);
                          },
                        ),
                      ),
                      EmptyButton(
                          onPressed: () {
                            if (!controller.isExporting) {
                              controller.exportCoursesExcel();
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
                      onRefresh: controller.getCourses,
                      isLoading: controller.isLoading,
                      isEmpty: controller.courses.isEmpty,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent - 100) {
                            controller.loadMore();
                          }
                          return false;
                        },
                        child: ListView.separated(
                          itemCount: controller.courses.length +
                              (controller.isLoadingMore ? 1 : 0),
                          separatorBuilder: (_, __) => const Divider(
                            color: AppColor.grey,
                            thickness: 0.2,
                          ),
                          itemBuilder: (context, index) {
                            if (index == controller.courses.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final course = controller.courses[index];

                            return InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  AdminCourseDetailsBottomSheet(
                                    course: course,
                                  ),
                                  isScrollControlled: true,
                                );
                              },
                              child: AdminCourseCard(
                                course: course,
                                onDelete: () {
                                  _confirmDelete(controller, course);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
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

void _confirmDelete(
    AdminCoursesController controller,
    AdminCourse course,
    ) {
  Get.bottomSheet(
    AlertBottomSheet(
      image: AppImageAsset.deleteTafakkud,
      title: "delete_course".tr,
      body: "confirm_delete_course".trParams({
        "name":course.name
      }),
      buttonTitle: 'delete'.tr,
      button1Color: AppColor.pink,
      onPress: () async {
        await controller.deleteCourse(course);
        Get.back();
      },
    ),
  );
}