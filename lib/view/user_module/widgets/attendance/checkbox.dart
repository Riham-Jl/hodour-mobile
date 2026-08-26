import 'package:flutter/material.dart';
import 'package:hodor/core/constants/colors.dart';


class MyCheckBox extends StatelessWidget {
  String label;
  bool attendance;
  Color? labelColor ;
  void Function(bool?)? onChanged;

   MyCheckBox({required this.label , required this.attendance ,this.onChanged,this.labelColor = AppColor.primaryColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
      scale: 1.4,
      child: Checkbox(
        value: attendance,
        onChanged: onChanged,
        side: const BorderSide(
            color: AppColor.lightGrey
        ),
        activeColor: AppColor.secondaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)),
      ),) ,
        Text(label , style: TextStyle(color: labelColor , fontWeight: FontWeight.bold),),
      ],
    );
  }
}
