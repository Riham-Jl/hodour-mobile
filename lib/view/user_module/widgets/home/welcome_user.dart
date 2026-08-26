import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/auth_controller.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("welcome".tr , style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 10,),
            Text(authController.user?.name??"", style: Theme.of(context).textTheme.displayLarge),
          ],
        ),);});
  }
}
