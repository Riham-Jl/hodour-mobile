import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';

import 'bottom_sheet_container.dart';
import 'image_picker_container.dart';


class EditImageBottomSheet extends StatelessWidget {
  bool existImage;
  void Function()? onPressDelete;
  void Function()? onPressGallery;
  void Function()? onPressCamera;
   EditImageBottomSheet({super.key ,required this.existImage  , this.onPressDelete , this.onPressGallery , this.onPressCamera});

  @override
  Widget build(BuildContext context) {
    return  BottomSheetContainer(
        isPage: false,
        widgets: [Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if(existImage) ImagePickerContainer(
              onPressed: onPressDelete,
              color: AppColor.lightPink,
              icon: AppImageAsset.close,
              text: "delete".tr,
            ),
            ImagePickerContainer(
              onPressed: onPressGallery,
              color: AppColor.blueWhite,
              icon: AppImageAsset.gallery,
              text: "gallery".tr ,),
            ImagePickerContainer(
                onPressed: onPressCamera,
                color: AppColor.blueWhite,
                icon: AppImageAsset.camera,
                text: "camera".tr)

          ],
        )]);
  }
}
