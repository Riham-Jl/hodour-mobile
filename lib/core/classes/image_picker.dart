import 'package:hodor/core/constants/colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class ImagePickerAndCrop {
   pickAndCrop(bool fromCamera) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = fromCamera
        ? await picker.pickImage(source: ImageSource.camera , imageQuality: 25)
        : await picker.pickImage(source: ImageSource.gallery , imageQuality: 25);
    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,

        uiSettings: [
          AndroidUiSettings(
            cropStyle: CropStyle.circle,
              toolbarColor: AppColor.primaryColor,
              toolbarWidgetColor: AppColor.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            cropStyle: CropStyle.circle,

          ),

        ],
      );
      if (croppedFile != null) {
       return croppedFile.path;
      }
    }
  }
}
