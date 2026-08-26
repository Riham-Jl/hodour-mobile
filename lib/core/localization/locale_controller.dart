import 'dart:ui';
import 'package:get/get.dart';
import '../app_state.dart';
import '../services/services.dart';

class LocaleController extends GetxController {
  Locale? language;
  final SettingsServices myServices = Get.find();

  @override
  void onInit() {
    final saved = myServices.sharedPrefs.getString("lang");
    if (saved != null && (saved == "ar" || saved == "en")) {
      language = Locale(saved);
    } else {
      final deviceCode = Get.deviceLocale?.languageCode ?? "en";
      language = Locale((deviceCode == "ar") ? "ar" : "en");
    }
    Get.updateLocale(language!);
    AppState.languageCode = language!.languageCode;

    super.onInit();
  }

  void changeLanguage(String langCode) {
    language = Locale(langCode);
    myServices.sharedPrefs.setString("lang", langCode);
    Get.updateLocale(language!);
    AppState.languageCode = langCode;
    Get.forceAppUpdate();
    update();
  }
}
