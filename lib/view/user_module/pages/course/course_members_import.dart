import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/images.dart';

import '../../../../controller/user_module/course/import_members_controller.dart';
import '../../../../core/constants/colors.dart';
import '../../widgets/common/empty_button.dart';
import '../../widgets/common/main_container.dart';
import '../../widgets/importing/course_card.dart';


class CourseImportPage extends StatelessWidget {
  const CourseImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImportMembersController>(builder: (controller) {
      return  MainContainer(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical:5),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("import_members".tr, style: TextStyle(color: AppColor.darkBlue, fontSize: 20 , fontWeight: FontWeight.bold),),
                    SizedBox(height: 8,),
                    Text("select_Course".tr , style: TextStyle(color: AppColor.secondaryColor, fontSize: 16 , fontWeight: FontWeight.bold),),

                  ],
                ),
              ),
             Expanded(child:
             controller.courses.isNotEmpty? ListView(
                    shrinkWrap: true,
                    children: [
                      ...List.generate(controller.courses.length, (index) {
                        return EmptyButton(
                          onPressed: (){
                            controller.openCourse(controller.courses[index]);
                          },
                          child: ImportCourseCard(course: controller.courses[index]),
                        );})
                    ],

                ):Center(
                  child:   Image.asset(AppImageAsset.empty),
                  ),
                ),

             ]),
      );});



  }}


