import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/core/constants/routes.dart';

import '../../../../controller/user_module/course/course_controller.dart';
import '../../../../controller/user_module/course/member_controller.dart';
import '../../../../core/constants/colors.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/data_container.dart';
import '../../widgets/common/main_container.dart';
import '../../widgets/common/search_text_field.dart';
import '../../widgets/members/member_card.dart';


class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
       return GetBuilder<MemberController>(builder: (controller) {
         return   GestureDetector(
           behavior: HitTestBehavior.translucent,
           onTap: () {
             FocusScope.of(context).unfocus();
           },
           child: MainContainer(
             child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical:5),
                  child:  Text( "members_name".tr , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 8),
                 child: SearchTextField(
                   searchStatus: controller.searchStatus,
                   theController: controller.searchController,
                   onChanged: (val){
                     controller.searchItem(val );
                   },
                   onTapClose:() {
                     controller.closeSearch();
                   }
                   ,
                   ),
               ),
               Expanded(
                 child: DataContainer(
                   onRefresh:(){
                     controller.getMembers(null);
                     return Future(() => true);
                   },
                   isLoading:  controller.isLoading,
                      isEmpty : controller.originList.isEmpty,
                     child:ListView(
                    shrinkWrap: true,
                    children: [
                      ...List.generate(controller.searchedList.length, (index) {
                        return MemberCard(member: controller.searchedList[index]);})
                           ],
                         )),
               ),
                 CustomButtonWidget(
                     title: "add_member".tr,
                     icon: Image.asset(AppImageAsset.addMember),
                     textColor: AppColor.primaryColor,
                     onPress: (){
                       controller.addMember();
                     }),
               CustomButtonWidget(
                   title: "import_members".tr,
                   icon: Image.asset(AppImageAsset.import , color: AppColor.pink,),
                   textColor: AppColor.pink,
                   onPress: (){
                     CourseController courseController = Get.find();
                     courseController.changePage(AppRoute.importMembersPage);
                   })
             ]),
           ),
         );});



}}

