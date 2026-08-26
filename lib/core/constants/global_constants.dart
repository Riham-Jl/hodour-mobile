// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GlobalConstants {
  static bool isInternet = true;

  static bool isUpgradeMessageNotShown = true;


  static const PLATFORM_ANDROID = "android";
  static const PLATFORM_IOS = "ios";

  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.teacharabia.thaber';
  static const APP_STORE_URL = 'https://apps.apple.com/app/id6455426926';

  static const NOT_SUPPORTED_ERROR_CODE = 106;
  static const NOT_REGISTERED_ERROR_CODE = 107;

  static const STATUS_VERSION_OPTIONAL_UPDATE = "optional-update";

}
