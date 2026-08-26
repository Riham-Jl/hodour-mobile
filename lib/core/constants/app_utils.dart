import 'dart:io';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'global_constants.dart';


class AppUtils {
  static String get appPlatform => Platform.operatingSystem;

  static Future<void> openApplicationStorePage() async {
    //await _launchUrl("https://caram.app/apps/driver-p.apk");
    if (appPlatform == GlobalConstants.PLATFORM_ANDROID) {
      await _launchUrl(GlobalConstants.PLAY_STORE_URL);
    } else if (appPlatform == GlobalConstants.PLATFORM_IOS) {
      await _launchUrl(GlobalConstants.APP_STORE_URL);
    }
  }

  static void exitApplication() {
    SystemNavigator.pop();
  }

  static Future<void> _launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
