import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/core/classes/app_user.dart';
import 'package:hodor/core/constants/routes.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/user.dart';
import 'package:hodor/rest_client.dart';
import 'package:hodor/singleton_rest_client_wrapper.dart';

class AuthController extends BaseController{

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  User? user;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  late TextEditingController userNameController;

  final GlobalKey<FormState> formKeyLogin = GlobalKey();
  final GlobalKey<FormState> formKeySignup = GlobalKey();


  String? fcmToken;




  @override
  void onInit() async{

     emailController = TextEditingController();
     passwordController = TextEditingController();
     rePasswordController = TextEditingController();
     userNameController = TextEditingController();

     await _googleSignIn.initialize();



     fcmToken =await  FirebaseMessaging.instance.getToken();
     print(fcmToken);

    super.onInit();
  }

  bool validate(GlobalKey<FormState> key) {
    if (key.currentState != null && !key.currentState!.validate()) {
      return false;
    } else {
      return true;

    }
  }

  Future<void> googleSignIn() async {
    isLoading = true;
    update();

    try {
      final GoogleSignInAccount? account = await _googleSignIn.authenticate();

      if (account == null) {
        return;
      }

      final auth = account.authentication;
      final idToken = auth.idToken;

      if (idToken == null || idToken.isEmpty) {
        Get.rawSnackbar(
          title: "connection_failed".tr,
          message: "Google ID token is missing",
        );
        return;
      }

      final platform = GetPlatform.isAndroid ? 'android' : 'ios';

      final resp = await networkCaller(
        restClient.googleLogin(
          idToken,
          platform,
          fcmToken,
        ),
      );

      await afterLogin(resp);
    } catch (e) {
      if (e is GoogleSignInException &&
          e.code == GoogleSignInExceptionCode.canceled) {
        return;
      }

      Get.rawSnackbar(
        title: "connection_failed".tr,
        message: e.toString(),
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future login() async {
    if (validate(formKeyLogin)) {
      return networkCaller(
        restClient.login(
          emailController.text,
          passwordController.text,
          fcmToken,
        ),
      ).then((value) async {
        await afterLogin(value);
      });
    }
  }

  Future<void> afterLogin(value) async {
    if (value.status == ResponseStatus.success) {
      userNameController.clear();
      passwordController.clear();
      rePasswordController.clear();
      emailController.clear();

      user = value.data;
      if(user?.language!=null) {
        Get.updateLocale(Locale(user!.language!));
      }

      saveUserData();
      updateDio();
      update();


      Get.offAllNamed(user!.is_admin??false ? AppRoute.adminPage : AppRoute.homePage);
    } else if (error != null) {
      errorHandling(error!);
    }
  }

  Future signUp() async {
    if (validate(formKeySignup)) {
      return networkCaller(
        restClient.signup(
          userNameController.text,
          emailController.text,
          passwordController.text,
          fcmToken,
          Get.locale?.languageCode
        ),
      ).then((value) async {
        await afterLogin(value);
      });
    }
  }

  void updateDio() {
    SingletonRestClient.instance.restClient = RestClient(
      SingletonRestClient.createDio(token: user?.access_token),
    );
  }

  Future<User?> getLoggedUser() async {
    int? userId = myServices.sharedPrefs.getInt(AppUser.userId);

    if (userId != null) {
      User user = User(
        id: userId,
        name: myServices.sharedPrefs.getString(AppUser.userName)!,
        email: myServices.sharedPrefs.getString(AppUser.userEmail)!,
        access_token:
        myServices.sharedPrefs.getString(AppUser.userAccessToken)!,
        image: myServices.sharedPrefs.getString(AppUser.userImage),
        is_admin: myServices.sharedPrefs.getBool(AppUser.isAdmin)
      );

      this.user = user;
      updateDio();

      return user;
    }

    return null;
  }

  void saveUserData() {
    myServices.sharedPrefs.setInt(AppUser.userId, user!.id);
    myServices.sharedPrefs.setString(AppUser.userName, user!.name);
    myServices.sharedPrefs.setString(AppUser.userEmail, user!.email);
    myServices.sharedPrefs.setBool(AppUser.isAdmin, user!.is_admin??false);
    myServices.sharedPrefs.setString(
      AppUser.userAccessToken,
      user!.access_token!,
    );

    if (user!.image != null) {
      myServices.sharedPrefs.setString(AppUser.userImage, user!.image!);
    }
  }

  Future clearUserData() async {
    await myServices.sharedPrefs.clear();
    user = null;
    updateDio();
  }

  Future logout() async {
    await _googleSignIn.signOut();

    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    final request = user?.is_admin == true
        ? restClient.adminLogout()
        : restClient.logout();

    return networkCaller(request).then((value) async {
      if (value.status == ResponseStatus.success) {
        await clearUserData();
        await Get.offAllNamed(AppRoute.loginPage);
      }
    });
  }

  void goToSignUp() {
    Get.offAllNamed(AppRoute.signUpPage);
  }
}