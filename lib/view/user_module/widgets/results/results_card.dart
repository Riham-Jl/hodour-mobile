import 'package:flutter/material.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/functions/date_functions.dart';
import 'package:hodor/model/course_result.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../common/custom_list.dart';

class ResultCard extends StatelessWidget {
   ResultCard({
    super.key,
    required this.result,
    this.onTap

  });

  final CourseResult result;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomList(
        onTap: onTap,
        title:Text( result.name , style: const TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold),),
        icons: Row( children: [
          Text(result.attendance+getDaysTerm(result.attendanceNum()) , style: TextStyle(color: result.success()?AppColor.secondaryColor:AppColor.pink , fontWeight: FontWeight.bold),),
          const SizedBox(width: 10,),
          CircularPercentIndicator(
            radius: 22.0,
            lineWidth: 4.0,
            percent:result.percentageNum()/100,
            center:  Text("${result.percentage}%" , style: const TextStyle(color: AppColor.primaryColor , fontSize: 10 , fontWeight: FontWeight.bold),),
            progressColor: result.percentageNum()<50? AppColor.pink:AppColor.secondaryColor,
            backgroundColor: AppColor.lightGrey,
          ),
        ]
        ));
  }
}
