import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/auth_controller.dart';

class LoadingStack extends StatelessWidget {
   LoadingStack({required this.child, super.key});

   Widget child;
    AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[
             child,
          if(controller.isLoading) Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator(),))
        ]
    );
  }
}
