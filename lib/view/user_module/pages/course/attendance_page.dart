import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/core/functions/date_functions.dart';
import 'package:hodor/model/session_attendance.dart';
import '../../../../controller/user_module/course/attendance_controller.dart';
import '../../widgets/attendance/attendance_card.dart';
import '../../widgets/attendance/check_all_card.dart';
import '../../widgets/common/bottom_sheet_container.dart';
import '../../widgets/common/course_title.dart';
import '../../widgets/common/empty_button.dart';
import '../../widgets/common/search_text_field.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AttendanceController());
    return GetBuilder<AttendanceController>(builder: (controller) {
      return  PopScope(
          onPopInvoked: controller.onPop,
          child:  GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: [
                BottomSheetContainer(
                        isPage: true,
                        widgets: [
                   CourseTitle(
                    name: controller.course.name,
                    description: controller.course.description,
                    widget: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: AppColor.lightGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        children: [
                          Text("${controller.session.session.day} ${getMonthName(controller.session.session.month)}" , style: const TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold , fontSize: 20 ,),),
                          Text(controller.session.note??"",style: const TextStyle(color: AppColor.grey ,  fontSize: 12 ),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchTextField(
                            searchStatus: controller.searchStatus,
                            theController: controller.searchController,
                            onChanged: (val){
                              controller.searchItem(val);
                            },
                            onTapClose:(){
                              controller.closeSearch();
                              }
                            ,
                          ),
                        ),
                          EmptyButton(
                             onPressed: (){
                               controller.filterAbsence();
                               },
                             child: Container(
                                 width: 45,
                                 height: 45,
                                 padding: const EdgeInsets.all(5),
                                 decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(17),
                                 border: Border.all(color: AppColor.secondaryColor ,width: 2),
                                 color: controller.filtered? AppColor.secondaryColor: AppColor.white
                                ),
                               child:Icon(Icons.person_remove , color: controller.filtered? AppColor.white : AppColor.secondaryColor,),
                             )
                          )
                      ],
                    ),
                  ),
                  CheckAllCard(controller: controller,withIcons: true,),
                  Expanded(
                    child: controller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                          : controller.originList.isEmpty
                        ? Image.asset(AppImageAsset.empty)
                        :ListView.builder(
                          padding: EdgeInsets.only(bottom: 60),
                      itemCount: controller.searchedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        SessionAttendance member = controller.searchedList[index];
                        return
                          AttendanceCard(member: member );
                      }
                    )


                  )]),
                Positioned(
                  bottom: 10,
                    left: 15,
                    child: IconButton(
                      onPressed: (){
                        controller.addMember();
                      },
                      style: IconButton.styleFrom(backgroundColor: AppColor.secondaryColor),
                      padding: const EdgeInsets.all(10),
                      icon: Image.asset(AppImageAsset.addMemberWhite),
                    ))
              ],
            ),
          ));
    });
  }
}

