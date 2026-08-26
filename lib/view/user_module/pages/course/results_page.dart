import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/model/course_result.dart';

import '../../../../controller/user_module/course/results_controller.dart';
import '../../widgets/common/data_container.dart';
import '../../widgets/common/empty_button.dart';
import '../../widgets/common/full_page_loader.dart';
import '../../widgets/common/main_container.dart';
import '../../widgets/common/search_text_field.dart';
import '../../widgets/results/results_card.dart';
import '../../widgets/results/results_header_container.dart';


class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ResultsController>(builder: (controller) {
      return   GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            MainContainer(
              topMargin: 65,
              child: Column(
                children: [
                  SizedBox(height: Get.width*0.25*0.5,),
                  Row(
                    children: [
                      Expanded(
                          child: SearchTextField(
                              searchStatus: controller.searchStatus,
                              theController: controller.searchController,
                              onChanged: (val){
                                controller.searchItem(val);
                              },
                              onTapClose:() {
                                controller.closeSearch();
                              }
                      )),
                      EmptyButton(
                          onPressed: (){
                            controller.openFilter();
                          },
                          child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: AppColor.secondaryColor
                        ),
                        child: Image.asset(AppImageAsset.filter),
                      )),
                      EmptyButton(
                          onPressed: (){
                            controller.getCourseResultsExcel();
                          },
                          child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: AppColor.green
                        ),
                        child: Image.asset(AppImageAsset.importExcel),
                      ))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: DataContainer(
                      onRefresh: controller.getCourseResults,
                      isLoading: controller.isLoading,
                          isEmpty :controller.searchedList.isEmpty,
                        child:  ListView(
                      shrinkWrap: true,
                      children: [
                        ...List.generate(controller.searchedList.length, (index) {
                          CourseResult result = controller.searchedList[index];
                          return ResultCard(
                              result: result,
                            onTap:(){
                              controller.goToMemberResults(result);
                            }
                          );
                        }),
                                          ],)
                    )
                ),


                ],
              ),
            ),
            Positioned(
              width: Get.width,
                top:65-Get.width*0.25/2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ResultsHeaderContainer(
                        number: controller.course.members_count.toString(),
                        title: "members_count".tr),
                    const SizedBox(width: 25,),
                    ResultsHeaderContainer(
                        number: controller.originList.isNotEmpty? controller.originList[0].all_days.toString():"0",
                        title: "sessions_count".tr)

                  ],
                )),
            if (controller.isExporting) FullPageLoader()

          ],
        ),
      );});


  }
}

