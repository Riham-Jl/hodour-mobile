import 'package:get/get.dart';
import 'package:hodor/controller/auth_controller.dart';
import 'package:hodor/controller/user_module/notifications_controller.dart';

class BindingControllers with Bindings{

  @override
  void dependencies(){
    Get.put(()=> AuthController(),permanent: true);
    Get.lazyPut(() => NotificationsController() , fenix: true);

  }
}