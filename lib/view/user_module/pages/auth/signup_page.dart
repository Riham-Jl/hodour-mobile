import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/auth_controller.dart';
import 'package:hodor/core/constants/routes.dart';
import 'package:hodor/core/functions/valid_input.dart';

import '../../widgets/auth/auth_input_text.dart';
import '../../widgets/auth/auth_switch_widget.dart';
import '../../widgets/auth/loading_stack.dart';
import '../../widgets/common/background_container.dart';
import '../../widgets/common/custom_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return BackgroundContainer(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: GetBuilder<AuthController>(builder: (controller) {
              return LoadingStack(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("new_account".tr , style:Theme.of(context).textTheme.titleLarge ),
                    Container(
                      margin: const EdgeInsets.only(top:20),
                      padding: EdgeInsets.symmetric(
                          horizontal:Get.width * 0.08),
                      child: Form(
                        key: controller.formKeySignup,
                        child:
                        Column(
                          children: [
                            AuthInputText(
                              textInputType: TextInputType.emailAddress,
                              textDirection: TextDirection.ltr,
                              hintText: "username".tr,
                              prefix: Image.asset( AppImageAsset.userIcon, width: 30,),
                              theController: controller.userNameController,
                              textInputAction: TextInputAction.next,
                              validator: (val){ return validInput(val!, 5, 50, "username");},),
                            AuthInputText(
                              textInputType: TextInputType.emailAddress,
                              textDirection: TextDirection.ltr,
                              hintText: "email".tr,
                              prefix: Image.asset( AppImageAsset.emailIcon, width: 30,),
                              theController: controller.emailController,
                              textInputAction: TextInputAction.next,
                              validator: (val){ return validInput(val!, 5, 50, "email");},),
                            AuthInputText(
                              textInputType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              textDirection: TextDirection.ltr,
                              hintText: "password".tr,
                              prefix: Image.asset(AppImageAsset.passwordIcon , width: 30,),
                              theController: controller.passwordController,
                              isPassword: true,
                              obscureText: true,
                              validator: (val){ return validInput(val!, 6, 50, "password");},
                            ),
                            AuthInputText(
                              onFieldSubmitted: (p0) {
                                controller.signUp();
                              },
                              textInputType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.go,
                              textDirection: TextDirection.ltr,
                              hintText: "confirm_password",
                              prefix: Image.asset(AppImageAsset.passwordIcon , width: 30,),
                              theController: controller.rePasswordController,
                              isPassword: true,
                              obscureText: true,
                              validator: (val){ return validInput(val!, 6, 50, "rePassword" ,password: controller.passwordController.text);},
                            ),
                            CustomButtonWidget(
                                title: "create_account".tr,
                                textColor: AppColor.white,
                                backgroundColor: AppColor.secondaryColor,
                                borderColor: Colors.transparent,
                                onPress: (){
                                  controller.signUp();
                                }),
                            const AuthSwitchWidget(),
                            CustomButtonWidget(
                                title: "have_account".tr,
                                textColor: Colors.white,
                                onPress: (){
                                  Get.offAllNamed(AppRoute.loginPage);
                                }),
                          ],
                        ),
                      ),),



                  ],
                ),
              );}),
          ),
        )

      ),
    );
  }
}
