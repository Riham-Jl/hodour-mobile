import 'package:flutter/material.dart';
import 'package:hodor/core/constants/box_shadow.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/model/course.dart';

class ImportCourseCard extends StatelessWidget {
  const ImportCourseCard({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.secondaryColor,
        boxShadow: [
          buildBoxShadow()
        ],
      ),
      child:
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.name , style: const TextStyle(color: AppColor.white , fontWeight: FontWeight.bold , fontSize: 16),),
                Text(course.description??"" , style: const TextStyle(color: AppColor.darkBlue , fontSize: 12 , fontWeight: FontWeight.bold),),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppImageAsset.membersIcon),
                Text(" ${course.members_count}" , style: const TextStyle(color: AppColor.white , fontSize: 16),),


              ],
            )
          ]),

    );
  }
}