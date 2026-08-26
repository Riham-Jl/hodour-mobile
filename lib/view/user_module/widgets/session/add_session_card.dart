import 'package:flutter/material.dart';
import 'package:hodor/core/constants/box_shadow.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';


class AddSessionCard extends StatelessWidget {
  void Function()? onTap;
   AddSessionCard({this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              buildBoxShadow()
            ],
          ),

          child: IconButton(
            onPressed: onTap,
            icon: Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.lightGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),

                ),

                child: Image.asset(AppImageAsset.addGrey)
            ),
          )
      ),
    );
  }
}
