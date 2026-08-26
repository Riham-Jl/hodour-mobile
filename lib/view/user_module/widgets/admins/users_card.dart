import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/model/course_user.dart';

import '../../../../controller/user_module/course/admins_controller.dart';
import '../common/custom_icon_button.dart';
import '../common/custom_list.dart';


class UsersCard extends StatelessWidget {
  UsersCard({
    required this.user,
    required this.index,
    required this.isInvited,
    super.key,
  });

  final CourseUser user;
  final int index;
  final bool isInvited;
  AdminsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomList(
        title: Text(user.name , style: const TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold),),
        icons:
        user.isOwner() && !isInvited? CustomIconButton(
          icon: AppImageAsset.owners,
          filled: false,)
            :controller.course.is_owner? CustomIconButton(
          icon: AppImageAsset.delete,
          onPressed: (){
            controller.deleteUser(user, index, !isInvited);
          },
        ):const SizedBox(height: 30,)



    );
  }
}
