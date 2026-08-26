import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';


class CustomTextField extends StatelessWidget {
  String hintText;
  TextEditingController? theController;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  Widget? suffixIcon;
  bool smallHint = false;
  void Function()? onTap;
  bool readOnly = false;

  CustomTextField({required this.hintText, this.theController, this.validator, this.keyboardType, this.suffixIcon ,this.onTap, this.readOnly=false, this.smallHint=false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: Get.height*0.07,
      child: TextFormField(
        readOnly: readOnly,
          keyboardType: keyboardType ,
          validator: validator,
          controller: theController,
          decoration: InputDecoration(
            hintStyle:smallHint? TextStyle(fontSize: 11):null,
              contentPadding: const EdgeInsets.symmetric(  horizontal: 15),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              ),
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: AppColor.lightGrey,
              hintText: hintText,

          ),
        onTap: onTap,
      ),
    );
  }
}

