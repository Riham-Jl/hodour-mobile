import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

import '../common/custom_list.dart';
import 'checkbox.dart';


class CheckAllCard extends StatelessWidget {
  CheckAllCard({
    required this.controller,
    required this.withIcons,
    super.key,
  });

final controller;
final bool withIcons;
  @override
  Widget build(BuildContext context) {
    return CustomList(
      title:
      MyCheckBox(
        label: controller.allChecked?"unselect_all".tr:"select_all".tr,
        labelColor: AppColor.grey.withOpacity(0.8),
        attendance: controller.allChecked,
        onChanged: (val){
          controller.checkAll();
        },
      ),
      icons: withIcons
          ? Text("${controller.attendance}/${controller.originList.length}" , style: TextStyle(color: AppColor.grey.withOpacity(0.8) , fontWeight: FontWeight.bold),)
          :Container()
      ,);
  }
}

