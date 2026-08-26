import 'package:flutter/material.dart';
import 'package:hodor/core/constants/colors.dart';

class CourseTitle extends StatelessWidget {
  String name;
  String? description;
  Widget? widget;
   CourseTitle({required this.name , this.description,  this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(widget!=null?0:10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
          color:widget==null? AppColor.lightGrey:AppColor.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(name , style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.bold , color: AppColor.darkBlue),),
              const SizedBox(height: 5,),
              Text(description?? "" , style: const TextStyle(fontSize: 12 , fontWeight: FontWeight.bold , color: AppColor.secondaryColor),),
            ],
          ),
          widget??Container()
        ],
      ),
    );
  }
}
