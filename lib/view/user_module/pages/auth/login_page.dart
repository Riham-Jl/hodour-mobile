import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/auth_controller.dart';
import 'package:hodor/core/functions/valid_input.dart';

import '../../widgets/auth/auth_input_text.dart';
import '../../widgets/auth/auth_switch_widget.dart';
import '../../widgets/auth/loading_stack.dart';
import '../../widgets/common/background_container.dart';
import '../../widgets/common/custom_button.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return BackgroundContainer(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body:  SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: GetBuilder<AuthController>(builder: (controller) {
                return LoadingStack(
                  child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("login".tr , style:Theme.of(context).textTheme.titleLarge ),
                  Container(
                    margin: const EdgeInsets.only(top:20),
              padding: EdgeInsets.symmetric(
                  horizontal:Get.width * 0.07),
                  child: Form(
                    key: controller.formKeyLogin,
                child:
                Column(
                  children: [
                    AuthInputText(
                        textInputType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        hintText: "email".tr,
                        prefix: Image.asset( AppImageAsset.emailIcon, width: 30,),
                    theController: controller.emailController,
                    textInputAction: TextInputAction.next,
                      validator: (val){ return validInput(val!, 5, 50, "email");},),
                    AuthInputText(
                      onFieldSubmitted: (p0) {
                        controller.login();
                      },
                      textInputAction: TextInputAction.go,
                      textInputType: TextInputType.visiblePassword,
                      textDirection: TextDirection.ltr,
                      hintText: "password".tr,
                      isPassword: true,
                      prefix: Image.asset(AppImageAsset.passwordIcon , width: 30,),
                      theController: controller.passwordController,
                      obscureText: true,
                     validator: (val){ return validInput(val!, 5, 50, "password");},
                    ),
                    CustomButtonWidget(
                        title: "login".tr,
                        textColor: AppColor.white,
                        backgroundColor: AppColor.secondaryColor,
                        borderColor: Colors.transparent,
                        onPress: (){
                         controller.login();
                        }),
                    const AuthSwitchWidget(),
                    CustomButtonWidget(
                        title: "login_with_google".tr,
                        textColor: Colors.white,
                        backgroundColor: Colors.black,
                        borderColor: Colors.transparent,
                        icon: Image.asset(AppImageAsset.google),
                        onPress: (){
                          controller.googleSignIn();
                        }),
                    const AuthSwitchWidget(),
                    CustomButtonWidget(
                        title: "create_new_account".tr,
                        textColor: Colors.white,
                        onPress: (){
                         controller.goToSignUp();
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
