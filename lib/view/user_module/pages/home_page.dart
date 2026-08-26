import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/user_module/notifications_controller.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/controller/user_module/home_controller.dart';

import '../widgets/appbar/app_bar.dart';
import '../widgets/appbar/notifications_appbar.dart';
import '../widgets/appbar/user_image_appbar.dart';
import '../widgets/common/background_container.dart';
import '../widgets/common/data_container.dart';
import '../widgets/home/add_course_button.dart';
import '../widgets/home/bottom_container.dart';
import '../widgets/home/course_card.dart';
import '../widgets/home/welcome_user.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
     HomeController homeController = Get.put(HomeController());
     Get.put(NotificationsController());
    return BackgroundContainer(
      child: Scaffold(
          appBar:  MyAppBar(
            leading: const UserImageAppBarWidget(),
            onTapLeading: (){
              homeController.goToProfile();
            },
            trailing: const NotificationsAppBarWidget(),
            onTapTrailing: (){
              homeController.goToNotification();
            },
          ),
          body:  SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const WelcomeUser(),
               GetBuilder<HomeController>(builder: (controller) {
                return Expanded(
                 child: Stack(
                   children:[
                     Container(
                     padding: const EdgeInsets.all(25),
                     width: Get.width,
                     decoration: const BoxDecoration(
                         color: AppColor.white,
                         borderRadius: BorderRadius.vertical(top: Radius.circular(40))
                     ),
                     child: DataContainer(
                       onRefresh: controller.getCourses,
                       isLoading: controller.isLoading,
                           isEmpty:controller.courses.isEmpty,
                         child: GridView.builder(
                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , crossAxisSpacing: 15 , mainAxisSpacing: 15),
                       itemCount: controller.courses.length,
                       itemBuilder: (BuildContext context, int index) {
                         return
                              CourseCard(
                                 onPressed: (){
                                   controller.goToCourse(controller.courses[index]);
                                 },
                               onTapSettings: (){
                                 controller.openCourseSettings(controller.courses[index]);
                               },
                                 course: controller.courses[index]);
                       }
                   ))
                     ),
                     Positioned(
                       bottom: 0,
                         child: Row(
                           children: [
                             HomeBottomContainer(
                               isLeft: Get.locale?.languageCode=="ar"? true : false,
                             ),
                             HomeBottomContainer(
                               isLeft: Get.locale?.languageCode=="ar"? false : true,
                             ),
                           ],
                         ),),
                     Positioned(
                       bottom: 10,
                         left: Get.width*0.40,
                         child:  AddCourseButton(
                           onPressed: (){
                             controller.addCourse();
                           },
                         ))
                   ]
                 ),
               );})
              ],
            ),
          )

        )

    );
  }
}



