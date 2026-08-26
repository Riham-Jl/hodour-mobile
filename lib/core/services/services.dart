import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_state.dart';

class SettingsServices extends GetxService{
  late SharedPreferences sharedPrefs;

  Future<SettingsServices> init() async{
    sharedPrefs = await SharedPreferences.getInstance();
    if (AppState.appVersion == null) {
      final packageInfo = await PackageInfo.fromPlatform();
      AppState.appVersion = packageInfo.version;
    }
    return this;
  }
}

Future initialServices() async{
  await Get.putAsync(() => SettingsServices().init());
}