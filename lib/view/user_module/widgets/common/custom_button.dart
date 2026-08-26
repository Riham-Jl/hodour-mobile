


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtonWidget extends StatelessWidget {

  String title ;
  Color textColor ;
  late Color? borderColor ;
  late Color backgroundColor ;
  Widget? icon;
  void Function () onPress ;
  double? fontSize;

  CustomButtonWidget ({super.key, required this.title , required this.textColor , required this.onPress , this.borderColor, this.backgroundColor = Colors.transparent , this.icon , this.fontSize } ){
    borderColor ??= textColor;
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        width: Get.width,
       // height: Get.height*0.06,
        child: OutlinedButton(

          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(10),

            side: BorderSide(width: 2.0, color: borderColor??textColor),
            backgroundColor: backgroundColor,
          ),
          onPressed: onPress,
          child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize??16 ),
                ),
                if(icon!=null)...[
                  const SizedBox(width: 6,),
                  icon!,

    ]
              ],
          ),

        ),
      ),
    );
  }

}