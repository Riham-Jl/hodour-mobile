import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

import '../../../../core/constants/images.dart';


class BottomSheetContainer extends StatelessWidget {
  List<Widget> widgets;
  bool isPage = false;
   BottomSheetContainer({required this.widgets, this.isPage=false, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:[
        Container(
          height:isPage? Get.height*0.94 :null ,
          width: Get.width,
         // margin: const EdgeInsets.only(top:20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.vertical(top:Radius.circular(50))
      ),
      child: Column(
      children: [
        GestureDetector(
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 30,
                    child: !isPage? GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: const Icon(Icons.close , size: 20,)):null,),
                  Image.asset(AppImageAsset.bottomSheetClose),
                  Container(
                    width: 30,
                  ),
                ],
              )),

        ),
        ...widgets,
      if(!isPage)const SizedBox(height: 30,)
      ]
      )),
   ])
    ;
  }
}

