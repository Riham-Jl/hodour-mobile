import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/functions/date_functions.dart';

import '../common/custom_text_field.dart';

class FilterSessionTextField extends StatelessWidget {
  final DateTime? session;
  void Function()? onTap;
  final String title;
  FilterSessionTextField({
    this.session,
    this.onTap,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width*0.40,
      child: CustomTextField(
        readOnly: true,
        hintText:session!=null? getStringDateFromDateTime(session!): title,
        smallHint: true,
        suffixIcon: const Icon(Icons.calendar_month_outlined , color: AppColor.grey, size: 18,),
        onTap: onTap,
      ),
    );
  }
}
