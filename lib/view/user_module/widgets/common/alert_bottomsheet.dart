import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

import 'bottom_sheet_container.dart';
import 'custom_button.dart';



class AlertBottomSheet extends StatefulWidget {
  String image;
  String title;
  String body;
  String buttonTitle;
  String? button2Title;
  Widget? button1Icon;
  Widget? button2Icon;
  Color? button1Color;
  void Function() onPress;
  void Function()? onPress2;
  AlertBottomSheet({required this.image, required this.title, required this.body, required this.buttonTitle,this.button2Title , required this.onPress, this.onPress2, this.button1Color, super.key});

  @override
  State<AlertBottomSheet> createState() => _AlertBottomSheetState();
}

class _AlertBottomSheetState extends State<AlertBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return  BottomSheetContainer(widgets: [
      Image.asset(widget.image),
      Container(
        margin: const EdgeInsets.only(top:20 , bottom: 5),
          child: Text(widget.title , style: const TextStyle(color: AppColor.darkBlue , fontWeight: FontWeight.bold , fontSize: 16),)),
      Text(widget.body , textAlign: TextAlign.center, style: const TextStyle(fontSize: 12 , height: 2),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: Get.width*0.35,
            child: CustomButtonWidget(
                title: widget.button2Title??"back".tr,
                textColor: AppColor.grey2,
                borderColor: AppColor.grey2,
                onPress: (){
                  if(widget.onPress2!=null){
                    setState(() {
                      widget.button1Icon=const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 3,));
                    });
                    widget.onPress2!();
                  }
                 else {
                    Get.back();
                  }
                }),
          ),
          SizedBox(
              width: Get.width*0.35,
              child: CustomButtonWidget(
                  title: widget.buttonTitle,
                  icon: widget.button1Icon,
                  textColor: AppColor.white,
                  backgroundColor: widget.button1Color?? AppColor.pink,
                  onPress:(){
                    setState(() {
                      widget.button1Icon=const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 3,));
                    });
                    widget.onPress();
                  }
              )),
        ],
      )

    ]);
  }
}
