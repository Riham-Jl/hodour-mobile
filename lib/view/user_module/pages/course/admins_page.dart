import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';

import '../../../../controller/user_module/course/admins_controller.dart';
import '../../widgets/admins/users_card.dart';
import '../../widgets/admins/users_title.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/data_container.dart';
import '../../widgets/common/main_container.dart';


class AdminsPage extends StatelessWidget {
  const AdminsPage({super.key});

  @override
  Widget build(BuildContext context) {
        return GetBuilder<AdminsController>(builder: (controller) {
          return
                MainContainer(
                  child: Column(
                    children: [
                      UsersTitle(title: "admins".tr,),
                  Expanded(
                    flex: 3,
                    child:DataContainer(
                      onRefresh: controller.getUsers,
                      isLoading: controller.isLoading,
                      isEmpty: controller.users.isEmpty,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ...List.generate(controller.users.length, (index) {
                            return UsersCard(
                              user: controller.users[index],
                              index: index,
                              isInvited: false,
                            );})


                        ],
                      ),
                    ),
                  ),
                  if(controller.course.is_owner)  UsersTitle(title: "join_requests".tr),
                  if(controller.course.is_owner)
                    Expanded(
                      flex: 3,
                      child:DataContainer(
                        onRefresh: controller.getUsers,
                        isLoading: controller.isLoading,
                        isEmpty: false,
                        child: ListView(
                        shrinkWrap: true,
                        children: [
                          ...List.generate(controller.invitedUsers.length, (index) {
                            return UsersCard(
                                user: controller.invitedUsers[index],
                                index: index,
                                isInvited: true) ;
                           })

                        ],
                                        ),
                      ),
                    ),
                      if(controller.course.is_owner)
                  CustomButtonWidget(
                      title: "add_admin".tr,
                      icon: Image.asset(AppImageAsset.addMember),
                      textColor: AppColor.primaryColor,
                      onPress: (){
                        controller.addUser();
                      })
                                ]),
                );


        });
  }
}



