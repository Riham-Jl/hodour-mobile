import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/theme.dart';
import 'package:hodor/core/constants/routes.dart';
import 'package:hodor/core/services/binding.dart';
import 'package:hodor/core/services/services.dart';
import 'package:hodor/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/localization/locale_controller.dart';
import 'core/localization/translation.dart';
import 'core/services/notification_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  final firebaseMessaging = FCM();
  firebaseMessaging.setNotifications();
  await initializeDateFormatting();
  await initialServices();
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LocaleController(), permanent: true);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetBuilder<LocaleController>(
        builder: (lc) {
      final locale = lc.language ?? const Locale("ar");

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslation(),
        locale: locale,
        title: 'Hodour',
        theme: myTheme,
        getPages: routes,
        initialBinding: BindingControllers(),
    );
        });
  }
}


