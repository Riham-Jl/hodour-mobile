import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

class SemiCircularButtonContainer extends StatelessWidget {
  bool pressedOne;
  String title1;
  String title2;
   void Function()? onPressed1;
  void Function()? onPressed2;



   SemiCircularButtonContainer({
     required this.pressedOne,
     required this.title1,
     required this.title2,
     required this.onPressed1,
     required this.onPressed2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Get.locale?.languageCode=="ar";
    return Container(
      width: Get.width*0.74+2,
      height: 40,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color:AppColor.grey)
      ),
      child: Row(
        children: [
          _SemiCircularButton(
              pressed: pressedOne,
              right: isArabic? true : false,
              title: title1,
              onPressed: onPressed1,
          ),
          _SemiCircularButton(
              pressed: !pressedOne,
              right: isArabic? false : true,
              title: title2,
              onPressed: onPressed2
          ),

        ],
      ),
    );
  }
}


class _SemiCircularButton extends StatelessWidget {
  bool pressed;
  bool right;
  String title;
  void Function()? onPressed;
  _SemiCircularButton({required this.pressed ,required this.right, required this.title,required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width*0.37,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:MaterialStateProperty.all<Color>(pressed? AppColor.primaryColor:AppColor.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: right?
                    const BorderRadius.only(bottomRight: Radius.circular(20) , topRight: Radius.circular(20))
                        :const BorderRadius.only(bottomLeft: Radius.circular(20) , topLeft: Radius.circular(20))
                )
            )
        )
        ,onPressed: onPressed,
        child:  Text(title , maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontSize: 12 ,fontWeight: FontWeight.bold, color: pressed? AppColor.white:AppColor.grey),),

      ),
    );
  }
}
