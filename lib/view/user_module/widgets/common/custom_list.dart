import 'package:flutter/material.dart';
import 'package:hodor/core/constants/colors.dart';


class CustomList extends StatelessWidget {
  Widget title;
  Widget icons;
  void Function()? onTap;
   CustomList({required this.title ,required this.icons, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide( //                   <--- left side
                  color: AppColor.grey.withOpacity(0.6)
              ),
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title,
        icons
      ])


      ),
    );
  }
}
