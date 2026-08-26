import 'dart:io';

class AppState {
  static bool isInternet = true;

  static bool isUpgradeMessageNotShown = true;


  static String? appVersion;
  static String? appVersionStatus;
  static String appPlatform = Platform.operatingSystem;

  static String? languageCode;

}