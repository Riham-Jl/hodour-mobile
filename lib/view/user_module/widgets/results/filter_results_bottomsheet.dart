import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/model/sort_type.dart';

import '../../../../controller/user_module/course/results_controller.dart';
import '../common/bottom_sheet_container.dart';
import '../common/custom_button.dart';
import 'filter_date_textfield.dart';




class FilterBottomSheet extends StatelessWidget {
  bool onlySession=false;

  FilterBottomSheet({this.onlySession=false, super.key});


  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ResultsController>(builder: (controller) {
      return BottomSheetContainer(
        widgets: [
      if(!onlySession)Column(
        children: [
           Text("sort_by".tr),
      MyRadio(
        value: SortType.alphaAsc ,
        groupValue: controller.sortType,
        title: "from_a_to_z".tr,
      ),
      MyRadio(
              value:SortType.alphaDesc ,
              groupValue: controller.sortType,
              title:"from_z_to_a".tr
      ),
      MyRadio(
          value:SortType.attendanceDesc ,
          groupValue: controller.sortType,
             title: "from_max_to_min".tr
      ),
      MyRadio(
              value:SortType.attendanceAsc ,
              groupValue: controller.sortType,
             title: "from_min_to_max".tr
      ),
      SizedBox(height: 20,),
        ],
      ),
       Text( "filter_by_custom_range".tr, style: TextStyle(color: AppColor.darkBlue , fontWeight: FontWeight.bold),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilterSessionTextField(
            session: controller.startSession,
            onTap: (){
              controller.showDatePicker();
            },
            title: "from".tr,
          ),
          FilterSessionTextField(
            session:controller.endSession,
              onTap: (){
                controller.showDatePicker();
              },
            title: "to".tr,
          ),
        ],
      ),

      const SizedBox(height: 30,),
      Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: SizedBox(
              height: 58,
              child: CustomButtonWidget(
                title: "cancel_filtration".tr,
                textColor: AppColor.grey,
                //backgroundColor: AppColor.secondaryColor,
                onPress: (){
                  controller.resetFilter();
                },
              ),
            ),
          ),
        Expanded(
          child: SizedBox(
            height: 60,
            child: CustomButtonWidget(
              title: "save".tr,
              textColor: AppColor.white,
              backgroundColor: AppColor.secondaryColor,
              onPress: (){
                controller.filter();
              },
            ),
          ),
        ),

      ],),

    ]);
    });
  }
}


class MyRadio extends StatelessWidget {
  final String title;
    final value;
  final groupValue;

   MyRadio({
    required this.value,
    required this.groupValue,
    required this.title,
    super.key,
  });

  ResultsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            value: value,
            groupValue: groupValue,
            onChanged: controller.chooseSortType,
        ),
        Text(title , style: const TextStyle(color: AppColor.grey , fontSize:14),),

      ],
    );
  }
}
