import 'package:flutter/material.dart';
import 'package:hodor/controller/user_module/profile_controller.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';

class EditProfileButton extends StatelessWidget {
  void Function()? onPressed;
  String title;
  bool isSelected;

   EditProfileButton({
     this.onPressed,
     required this.title,
     required this.isSelected,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
          side: const BorderSide( color: AppColor.lightGrey),
          backgroundColor: AppColor.white,
        ),
        onPressed: onPressed,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
             title,
              style: const TextStyle(color: AppColor.grey),
            ),
            isSelected
            ? Image.asset(AppImageAsset.arrowOpened)
            : Icon( Icons.arrow_forward_ios , color: Colors.grey[400],)
          ],
        ),

      ),
    );
  }
}
