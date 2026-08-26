import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';

import '../../../../controller/user_module/course/member_results_controller.dart';
import '../../widgets/appbar/app_bar.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/background_container.dart';
import '../../widgets/common/data_container.dart';
import '../../widgets/common/empty_button.dart';
import '../../widgets/common/full_page_loader.dart';
import '../../widgets/common/main_container.dart';
import '../../widgets/results/member_result_card.dart';
import '../../widgets/results/member_result_header.dart';


class MemberResultsPage extends StatelessWidget {
  const MemberResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MemberResultsController());
    return  GetBuilder<MemberResultsController>(builder: (controller) {
        return BackgroundContainer(
            child:  Scaffold(
              floatingActionButton: EmptyButton(
                  onPressed: (){
                      controller.getMemberResultsExcel();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: AppColor.green
                    ),
                    child: Image.asset(AppImageAsset.importExcel),
                  )),
            appBar: MyAppBar(

        leading:  AppBackButton(),
        onTapLeading: (){
        Get.back();
        },
        title: controller.course.name,
        ),
        body: Stack(
        children: [
          MainContainer(
            topMargin: 65,
            child: Column(
              children: [
                SizedBox(height: Get.width*0.25*0.5,),
                Expanded(
                  child:  DataContainer(
                      onRefresh: controller.getMemberResults,
                     isLoading: controller.isLoading,
                          isEmpty:controller.results.isEmpty,
                      child:  ListView(
                  shrinkWrap: true,
                  children: [
                    ...List.generate(controller.results.length, (index) {
                      return MemberResultCard(result: controller.results[index]);
                    }),
                                      ],)
                  )
              ),

              ],
            ),
          ),
          Positioned(
            width: Get.width*0.75,
              right: Get.width*0.125,
              top:65-Get.width*0.3/2,
              child: MemberResultHeader()),
          if (controller.isExporting) FullPageLoader()

        ],
      )));
    });


  }
}

