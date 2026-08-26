import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/model/member.dart';

import '../../../../controller/user_module/course/member_controller.dart';
import '../common/custom_icon_button.dart';
import '../common/custom_list.dart';

class MemberCard extends StatelessWidget {
   MemberCard({
    super.key,
    required this.member,
  });

  final Member member;
   MemberController controller = Get.find();


   @override
  Widget build(BuildContext context) {
    return CustomList(
      title: Column(
        children: [
          Text(member.name , style: const TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold),),
          if(member.note!=null) Text(member.note! , style: const TextStyle(fontSize: 10),)
        ],
      ),
      icons: Row(
          children: [
            CustomIconButton(
                onPressed: (){
                  controller.editMember(member.id, member.name , member.note);
                },
                icon: AppImageAsset.editBlack),
            CustomIconButton(
                onPressed: (){
                  controller.deleteMember(member);
                },
                icon: AppImageAsset.delete),

          ]),

    );
  }
}
