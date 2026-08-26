import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hodor/core/classes/app_user.dart';
import 'package:hodor/core/constants/routes.dart';
import 'package:hodor/core/services/services.dart';

class AuthMiddleWare extends GetMiddleware{
  SettingsServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route){
    if(myServices.sharedPrefs.getInt(AppUser.userId)!=null){
      return  RouteSettings(name:
      myServices.sharedPrefs.getBool(AppUser.isAdmin)==true
          ? AppRoute.adminPage
          : AppRoute.homePage);
    }
  }
}