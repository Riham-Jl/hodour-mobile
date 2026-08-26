import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/images.dart';


import '../../../../controller/user_module/course/course_controller.dart';
import '../../widgets/appbar/app_bar.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/background_container.dart';
import '../../widgets/course/course_drawer.dart';


class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
      Get.put(CourseController);
    return GetBuilder<CourseController>(builder: (controller) {
      return BackgroundContainer(
      child: PopScope(
        onPopInvoked: controller.onPop,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
          key: controller.scaffoldKey,
          appBar: MyAppBar(
            trailing: Image.asset(AppImageAsset.drawer),
              onTapTrailing: (){
              controller.openDrawer();
            },
            leading:  AppBackButton(),
            onTapLeading: (){
             Get.back();
            },
            title: controller.course?.name??"",
          ),
          endDrawer: const CourseDrawer(),
          body:
           SafeArea(
             top: false,
               child: controller.pages[controller.currentPage]??SizedBox())

        ),
      ),
    );

    });
  }
}
