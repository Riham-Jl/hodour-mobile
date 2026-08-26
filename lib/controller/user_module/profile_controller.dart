import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/auth_controller.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/core/classes/app_user.dart';
import 'package:hodor/core/classes/image_picker.dart';
import 'package:hodor/core/functions/message_toast.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/user.dart';

import '../../core/constants/routes.dart';
import '../../core/localization/locale_controller.dart';
import '../../view/user_module/widgets/common/alert_bottomsheet.dart';
import 'notifications_controller.dart';

enum EditStatus{
  none,
  profile,
  password,
  language
}
class ProfileController extends BaseController{

  AuthController authController = Get.find();


   User? user;
  late TextEditingController oldPasswordController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  late TextEditingController userNameController;

  final GlobalKey<FormState> formKeyEditName = GlobalKey();
  final GlobalKey<FormState> formKeyEditPassword = GlobalKey();

  EditStatus editStatus= EditStatus.none;

  String selectedLanguage = "en";


  @override
  void onInit() async{

     oldPasswordController = TextEditingController();
     passwordController = TextEditingController();
     rePasswordController = TextEditingController();
     userNameController = TextEditingController();
     initLanguage();
     getProfile();
    super.onInit();
  }

  changeEditStatus(EditStatus status){
    editStatus == status
        ? editStatus =EditStatus.none
        : editStatus= status;
    update();
  }

  void initLanguage() {
    selectedLanguage = Get.locale?.languageCode ?? "en";
  }

  void changeLanguageSelection(String value) {
    selectedLanguage = value;
    update();
  }



  bool validate(GlobalKey<FormState> key) {
    if (key.currentState != null && !key.currentState!.validate()) {
      return false;
    } else {
     // formKeySignup.currentState?.save();
      return true;

    }
  }

  Future getProfile() async {
    return networkCaller(
        restClient.getProfile())
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        user = value.data;
        userNameController.text=user!.name;
        authController.saveUserData();
      }
      else if (error != null) {
        errorHandling(error!);
      }
    });
  }




  Future updatePassword(  ) async {
    if(validate(formKeyEditPassword)) {
    return networkCaller(
        restClient.updateUser(null ,oldPasswordController.text, passwordController.text ))
        .then((value) async {
          oldPasswordController.clear();
          passwordController.clear();
          rePasswordController.clear();
      if (value.status == ResponseStatus.success) {
        showMessageInToast("edited_successfully".tr);
        editStatus= EditStatus.none;
        update();

      }else if (error != null) {
        errorHandling(error!);
      }
    });
  }
  }

  Future updateProfile(  ) async {
    if(validate(formKeyEditName)) {
      return networkCaller(
          restClient.updateUser(userNameController.text ,null , null ))
          .then((value) async {
        if (value.status == ResponseStatus.success) {
          showMessageInToast("edited_successfully".tr);
          editStatus=EditStatus.none;
          user = value.data;
          authController.user!.name = user!.name;
          authController.update();
          update();

        }else if (error != null) {
          errorHandling(error!);
        }
      });
    }
  }

  Future<void> updateLanguageOnServer(String langCode) async {
    await networkCaller(
      restClient.changeLanguage(langCode),
    );

  }

  void saveLanguage() async {
    final localeCtrl = Get.find<LocaleController>();

    if (selectedLanguage == Get.locale?.languageCode) {
      editStatus = EditStatus.none;
      update();
      return;
    }

    localeCtrl.changeLanguage(selectedLanguage);

    await updateLanguageOnServer(selectedLanguage);

    editStatus = EditStatus.none;
    update();
  }



  Future updateUserImage(bool camera) async {
    ImagePickerAndCrop imagePickerAndCrop = ImagePickerAndCrop();
    Get.back();
    await imagePickerAndCrop.pickAndCrop(camera).then((filePath) async{
      if(filePath!=null)  {
        File file = File(filePath!);
        int fileSize =await (file.length());
        if (fileSize < 2097152) {
        return networkCaller(
            restClient.updateUserImage(file))
            .then((value) async {
          if (value.status == ResponseStatus.success) {
            user = value.data;
            authController.user!.image=user!.image;
            authController.update();
            myServices.sharedPrefs.setString(AppUser.userImage, user!.image!);
          } else if (error != null) {
            errorHandling(error!);
          }
        });}
        else {
        Get.rawSnackbar(message: "image_size_validation".tr);
      }}
      });
  }

  Future deleteUserImage( ) async {
    Get.back();
    return networkCaller(
        restClient.deleteUserImage(true))
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        user!.image="";
        authController.user!.image=null;
        authController.update();
        myServices.sharedPrefs.remove(AppUser.userImage);
        update();
      }else if (error != null) {
        errorHandling(error!);
      }
    });
  }


  askLogOut(){
    Get.bottomSheet(
      AlertBottomSheet(
        image: AppImageAsset.out,
        title: "logout".tr,
        body: "confirm_logout".trParams({
          "email":user?.email??""
        }),
        buttonTitle: "out".tr,
        onPress: () {
          authController.logout();
        }
    ));
  }

  goToNotification({bool fromProfile=false}){
    NotificationsController nController = Get.find();
    nController.getNotifications();
     Get.offNamed(AppRoute.notificationsPage);
  }

}
