import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/box_shadow.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/user_module/profile_controller.dart';

import '../common/edit_image_bottom_sheet.dart';

class ProfileImage extends StatelessWidget {
  ProfileImage({
    required this.image,
    super.key,
  });

  String? image;
  ProfileController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none ,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircleAvatar(
            foregroundImage: image!=null?NetworkImage(image!):null,
            backgroundImage: const AssetImage(AppImageAsset.profile),
          ),
        ),
        Positioned(
            bottom: 0,
            right: -8,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  buildBoxShadow()
                ],
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){
                  Get.bottomSheet(
                      EditImageBottomSheet(
                        existImage: image!="",
                        onPressDelete:(){
                          controller.deleteUserImage();
                        } ,
                        onPressGallery: (){
                          controller.updateUserImage(false);
                        } ,
                        onPressCamera: (){
                          controller.updateUserImage(true);
                        },
                      )
                  );
                },
                icon: Image.asset(AppImageAsset.editBlue),
              ),
            ))
      ],
    );
  }
}

