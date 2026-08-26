import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/images.dart';


class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: Alignment.center,
        transform: Get.locale?.languageCode=="ar"
            ?  Matrix4.rotationY(3.1416)
            :Matrix4.rotationY(0),
        child: Image.asset(AppImageAsset.back));
  }
}
