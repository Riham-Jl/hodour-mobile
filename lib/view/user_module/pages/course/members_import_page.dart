import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/model/member.dart';

import '../../../../controller/user_module/course/import_members_controller.dart';
import '../../widgets/attendance/check_all_card.dart';
import '../../widgets/attendance/checkbox.dart';
import '../../widgets/common/bottom_sheet_container.dart';
import '../../widgets/common/course_title.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_list.dart';
import '../../widgets/common/data_container.dart';
import '../../widgets/common/search_text_field.dart';

class MembersImportPage extends StatelessWidget {
  const MembersImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImportMembersController>(builder: (controller) {
      return BottomSheetContainer(
        isPage: true,
        widgets: [
             CourseTitle(
              name: controller.selectedCourse!.name,
              description: controller.selectedCourse!.description,
               widget: Container(),

            ),
            SearchTextField(
              searchStatus: controller.searchStatus,
              theController: controller.searchController,
              onChanged: (val){
                controller.searchItem(val );
              },
              onTapClose:() {
                 controller.closeSearch();
              }
            ),
            CheckAllCard(controller: controller, withIcons: false),
            Expanded(
              child:  DataContainer(
      onRefresh:(){
        controller.getMembers(controller.selectedCourse);
        return Future(() => true);
        },
      isLoading: controller.isLoading,
          isEmpty:controller.searchedList.isEmpty,
      child:  ListView.builder(
                itemCount: controller.searchedList.length,
                itemBuilder: (BuildContext context, int index) {
                  Member member = controller.searchedList[index];
                  return
                    CustomList(title:
                        MyCheckBox(
                          label:member.name ,
                          attendance: member.attendance??false,
                          onChanged: (val){
                            controller.changeAttendance(member.id, val!);
                            },),
                         icons: Container()

                     );
                }
              )
            )),
            Container(
              margin: EdgeInsets.all(5),
              width: Get.width,
              child:
                  CustomButtonWidget(
                      title: "import".tr,
                       onPress:() {
                         controller.importMembers();
                       },
                    textColor: AppColor.white,
                    backgroundColor: AppColor.secondaryColor,
                    icon: Image.asset(AppImageAsset.importWhite),
                     )

            )

            ],
        );
    });
  }
}
