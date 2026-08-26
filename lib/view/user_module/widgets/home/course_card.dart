import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/box_shadow.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/model/course.dart';

import '../common/empty_button.dart';


class CourseCard extends StatelessWidget {
  Course course;
  void Function()? onTapSettings;
  void Function()? onPressed;


  CourseCard({required this.course , this.onTapSettings , this.onPressed });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Get.locale?.languageCode=="ar";
    return EmptyButton(
      onPressed: onPressed,
      child: Container(
        padding:  EdgeInsets.only(top:15 , bottom: 6 , right: isArabic? 15 : 8 , left: isArabic? 8 : 15),
        decoration: BoxDecoration(
            color: course.pinned==0? AppColor.secondaryColor:AppColor.green,
            borderRadius: BorderRadius.circular(25),
          boxShadow: [
            buildBoxShadow()
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course.name , style: Theme.of(context).textTheme.displayMedium,),
            const SizedBox(height: 5,),
            Text(course.description??"",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displaySmall,
            ) ,
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Image.asset(AppImageAsset.membersIcon),
                  const SizedBox(width: 5,),
                   Text(course.members_count.toString() , style: const TextStyle(color: AppColor.darkBlue , fontSize: 18),)
                ],),
                GestureDetector(
                  onTap: onTapSettings,
                  child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Image.asset( AppImageAsset.tafakkudIcon, color:course.pinned==0 ? null: AppColor.green,)
                  ),
                )
              ],)
          ],
        ),
      ),
    );
  }
}
