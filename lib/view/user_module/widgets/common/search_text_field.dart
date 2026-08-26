import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';



class SearchTextField extends StatelessWidget {
  TextEditingController? theController;
  void Function(String)? onChanged;
  void Function()? onTap;
  void Function()? onTapClose;
  bool searchStatus = false;
  bool readOnly = false;
   SearchTextField({ this.theController,  this.onChanged, this.onTapClose,this.onTap, this.searchStatus=false, this.readOnly=false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        readOnly: readOnly,
        controller: theController,
          onTap: onTap,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(  horizontal: 15),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            filled: true,
            fillColor: AppColor.lightGrey,
            hintText: "search".tr,
            suffixIcon: searchStatus?  InkWell(
              onTap: onTapClose,
                    child: const Icon(Icons.close)):null

      )),
    );
  }
}
