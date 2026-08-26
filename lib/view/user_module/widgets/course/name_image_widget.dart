import 'package:flutter/material.dart';
import 'package:hodor/core/constants/colors.dart';

class NameImageWidget extends StatelessWidget {
  String backgroundImage;
  String? foregroundImage;
  String title;
  String description;
  bool withBorder = false;
   NameImageWidget({required this.backgroundImage , this.foregroundImage , required this.title , required this.description, this.withBorder=false, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor:withBorder? AppColor.secondaryColor:null,
            radius: withBorder? 28.0 :25,
            child: CircleAvatar(
              backgroundImage: AssetImage(backgroundImage),
              foregroundImage: foregroundImage!=null? NetworkImage(foregroundImage!):null,
              radius: 25,
            )),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title , style: const TextStyle(color: AppColor.white ,fontSize: 18, fontWeight: FontWeight.bold),),
              Text(description, style: const TextStyle(color: AppColor.secondaryColor , fontSize: 11 ),),
            ],
          ),
        )
      ],
    );
  }
}
