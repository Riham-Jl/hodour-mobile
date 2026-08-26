import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/model/session_attendance.dart';

import '../../../../controller/user_module/course/attendance_controller.dart';
import '../common/custom_icon_button.dart';
import '../common/custom_list.dart';
import 'checkbox.dart';


class AttendanceCard extends StatelessWidget {
   AttendanceCard({
    super.key,
    required this.member,
  });

  final SessionAttendance member;
  AttendanceController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    return CustomList(
      title: MyCheckBox(
        label: member.member_name ,
        attendance: member.attendance==1,
        onChanged: (val){
          controller.changeAttendance(member.id, val==true?1:0);
        },),
      icons:
      member.note == null
          ? CustomIconButton(
          onPressed: (){
            controller.addEditNote(member.id , true);
          },
          icon: AppImageAsset.addNote
      )
          :CustomIconButton(
        onPressed: (){
          controller.addEditNote(member.id , false);
        },
        icon:AppImageAsset.note,
        filled: false,),

    );
  }
}
