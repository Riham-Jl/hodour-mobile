import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/user_module/profile_controller.dart';
import 'package:hodor/core/functions/valid_input.dart';

import '../../widgets/appbar/app_bar.dart';
import '../../widgets/auth/auth_input_text.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/background_container.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/data_container.dart';
import '../../widgets/profile/profile_button.dart';
import '../../widgets/profile/profile_image.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return BackgroundContainer(
        child: Scaffold(
            appBar: MyAppBar(
              leading: AppBackButton(),
              onTapLeading: () {
                Get.back();
              },
              title: "",
            ),
            body:  GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: GetBuilder<ProfileController>(builder: (controller) {
                  return Container(
                    margin:  EdgeInsets.only(top:controller.editStatus!=EditStatus.password?Get.height*0.1:20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 30 , right: 30 , left: 30),
                          width: Get.width,
                          height: Get.height,
                          decoration: const BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(50))
                          ),
                          child: DataContainer(
                            onRefresh: controller.getProfile,
                            isLoading: controller.isLoading,
                            isEmpty: false,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                  children: [
                                    const SizedBox(height: 40,),
                                     Center(child: Text(controller.user?.name??"" , style: const TextStyle(color: AppColor.darkBlue ,fontSize: 22, fontWeight: FontWeight.bold),)),
                                     Center(child: Text(controller.user?.email??"" , style: const TextStyle(color: AppColor.secondaryColor),)),
                                    const SizedBox(height: 20,),
                                    EditProfileButton(
                                      onPressed: (){
                                        controller.changeEditStatus(EditStatus.profile);
                                      },
                                        title:  "edit_profile".tr,
                                        isSelected: controller.editStatus==EditStatus.profile,
                                    ),
                                    if(controller.editStatus==EditStatus.profile)
                                      Form(
                                      key:controller.formKeyEditName ,
                                      child: Column(
                                        children: [
                                        AuthInputText(
                                          backgroundColor: AppColor.lightGrey,
                                            hintText: "name".tr,
                                            suffix: Image.asset( AppImageAsset.userIcon, width: 30,),
                                            theController: controller.userNameController,
                                            textInputAction: TextInputAction.next,
                                            validator: (val){ return validInput(val!, 4, 50, "");},),
                                          CustomButtonWidget(
                                              title: "save".tr,
                                              textColor: AppColor.white,
                                              backgroundColor: AppColor.secondaryColor,
                                              onPress: (){
                                                controller.updateProfile();
                                              })
                                        ],
                                      ),
                                    ),
                                    EditProfileButton(
                                        onPressed: (){
                                          controller.changeEditStatus(EditStatus.password);
                                        },
                                        title: "edit_password".tr,
                                        isSelected: controller.editStatus == EditStatus.password),
                                    if(controller.editStatus== EditStatus.password)
                                      Form(
                                      key: controller.formKeyEditPassword,
                                      child: Column(
                                        children: [
                                          AuthInputText(
                                            backgroundColor: AppColor.lightGrey,
                                            textInputType: TextInputType.visiblePassword,
                                            textDirection: TextDirection.ltr,
                                            hintText: "current_password".tr,
                                            prefix: Image.asset(AppImageAsset.passwordIcon , width: 30,),
                                            theController: controller.oldPasswordController,
                                            isPassword: true,
                                            obscureText: true,
                                            validator: (val){ return validInput(val!, 6, 50, "password");},
                                          ),
                                          AuthInputText(
                                            backgroundColor: AppColor.lightGrey,
                                            textInputType: TextInputType.visiblePassword,
                                            textDirection: TextDirection.ltr,
                                            hintText: "new_password".tr,
                                            prefix: Image.asset(AppImageAsset.passwordIcon , width: 30,),
                                            theController: controller.passwordController,
                                            isPassword: true,
                                            obscureText: true,
                                            validator: (val){ return validInput(val!, 6, 50, "password");},
                                          ),
                                          AuthInputText(
                                            backgroundColor: AppColor.lightGrey,
                                            textInputType: TextInputType.visiblePassword,
                                            textDirection: TextDirection.ltr,
                                            hintText: "confirm_new_password".tr,
                                            prefix: Image.asset(AppImageAsset.passwordIcon , width: 30,),
                                            theController: controller.rePasswordController,
                                            isPassword: true,
                                            obscureText: true,
                                            validator: (val){ return validInput(val!, 6, 50, "rePassword" ,password: controller.passwordController.text);},
                                          ),

                                          CustomButtonWidget(
                                              title: "save".tr,
                                              textColor: AppColor.white,
                                              backgroundColor: AppColor.secondaryColor,
                                              onPress: (){
                                                controller.updatePassword();
                                              }),

                                        ],
                                      ),
                                    ),
                                    EditProfileButton(
                                      title: "language".tr,
                                      isSelected: controller.editStatus == EditStatus.language,
                                      onPressed: () {
                                        controller.changeEditStatus(EditStatus.language);
                                      },
                                    ),

                                    if (controller.editStatus == EditStatus.language)
                                      Column(
                                        children: [
                                          RadioListTile<String>(
                                            value: 'ar',
                                            groupValue: controller.selectedLanguage,
                                            title: const Text('العربية' , style: TextStyle(fontSize: 14),),
                                            dense: true,
                                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                            onChanged: (v) {
                                              if (v == null) return;
                                              controller.changeLanguageSelection(v);
                                            },

                                          ),
                                          RadioListTile<String>(
                                            value: 'en',
                                            groupValue: controller.selectedLanguage,
                                            title: const Text('English' , style: TextStyle(fontSize: 14),),
                                            dense: true,
                                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                            onChanged: (v) {
                                              if (v == null) return;
                                              controller.changeLanguageSelection(v);
                                            },
                                          ),

                                          CustomButtonWidget(
                                            title: "save".tr,
                                            textColor: AppColor.white,
                                            backgroundColor: AppColor.secondaryColor,
                                            onPress: () {
                                              controller.saveLanguage();
                                            },
                                          ),
                                        ],
                                      ),
                                  ],
                                                          ),
                                ),
                                CustomButtonWidget(
                                    title: "logout".tr,
                                    textColor: AppColor.white,
                                    backgroundColor: AppColor.pink,
                                    onPress: (){
                                      controller.askLogOut();
                                    }),
                              ],
                            ))
                        ),
                        Positioned(
                          right: Get.width*0.5-60,
                          top: -60,
                            child: ProfileImage(image: controller.user?.image,))
                      ],
                    )
                  );
                           }
                ),
              ),
            )));
  }



}




