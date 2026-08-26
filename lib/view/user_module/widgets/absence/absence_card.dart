import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';

import '../../../../controller/user_module/course/absence_controller.dart';


class AbsenceCard extends StatelessWidget {
  bool recurrentAbsence;
  List data;
  String title1;
  String? title2;
  String? absenceMembersCount;
  void Function()? onTap;
  int selectedIndex;
  int index;
  AbsenceCard({required this.recurrentAbsence, required this.data, required this.title1 , this.title2, this.absenceMembersCount,required this.onTap , required this.selectedIndex , required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color:AppColor.lightGrey),
      ),
      child: Column(
        spacing: 8,
        children: [
        InkWell(
        onTap: onTap,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                  children: [
                    Text(title1 , style: const TextStyle(color: AppColor.primaryColor),),
                    if(title2!=null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(title2!),
                      )
                  ],
                ),

              Row(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(absenceMembersCount!=null)
                    Text(absenceMembersCount! , style: const TextStyle(color:Colors.red , fontSize: 16),),
                  selectedIndex==index
                      ? Image.asset(AppImageAsset.arrowOpened)
                      : Icon( Icons.arrow_forward_ios , color: Colors.grey[400], size: 18,),
                ],
              )
            ],
          ),),
          Visibility(
            visible:  index==selectedIndex,
            child: GetBuilder<AbsenceController>(builder: (controller) {
             return Container(
              margin: const EdgeInsets.only(top:5),
              child: controller.isLoading?
                  const CircularProgressIndicator()
              :Column(
                spacing: 5,
                children: List.generate(recurrentAbsence? data[index].members.length:data.length, (i) {
                  return Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 6 , horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightGrey
                    ),
                    child: Text(recurrentAbsence? data[index].members[i].name:data[i].member_name),
                  );
                }),
              ),
            );}),
          )
        ],
      ),);
  }
}
