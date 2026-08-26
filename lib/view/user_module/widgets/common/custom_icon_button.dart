import 'package:flutter/material.dart';
import 'package:hodor/core/constants/colors.dart';

class CustomIconButton extends StatelessWidget {
  String icon;
  bool filled = true;
  void Function()? onPressed;
  Color? color;
   CustomIconButton({required this.icon, this.filled=true, this.onPressed ,this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
          color: color?? AppColor.lightGrey.withOpacity(filled? 0.6:0),
          borderRadius: BorderRadius.circular(30)
      ),
      child:
      IconButton(
        onPressed: onPressed,
        icon: Image.asset(icon , width: 25, color: AppColor.secondaryColor, ) ,
        padding: EdgeInsets.zero,
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
        ),
      ),

    );
  }
}
