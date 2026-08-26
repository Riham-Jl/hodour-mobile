import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/auth_controller.dart';
import 'package:hodor/core/constants/app_utils.dart';
import 'package:hodor/core/constants/routes.dart';
import 'package:hodor/core/functions/check_internet.dart';
import 'package:hodor/core/services/services.dart';
import 'package:hodor/core/constants/global_constants.dart';
import 'package:hodor/model/response_model.dart';
import 'package:hodor/model/error.dart';

import '../model/response_status.dart';
import '../rest_client.dart';
import '../singleton_rest_client_wrapper.dart';
import '../view/user_module/widgets/common/alert_dialog.dart';
import '../view/user_module/widgets/common/app_version_update_dialog.dart';

 class BaseController extends GetxController{

  bool isLoading = false;
  Error? error;
  late  StreamSubscription<dynamic> listener ;

  SettingsServices myServices = Get.find();

  RestClient get restClient => SingletonRestClient.instance.restClient;
  ResponseStatus? responseStatus;


  @override
  onReady() {
    checkInternet();
    super.onReady();
  }



  startAuthFlow(){
    AuthController authController = Get.put(AuthController());
    authController.clearUserData();
   Get.offAllNamed(AppRoute.loginPage);
  }


  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
      update();

  }

  void setError(Error? error) {
    this.error = error;
    update();
  }

  Future<ResponseModel> networkCaller(Future<ResponseModel> task,
      {bool withLoading = true}) async {
    if (withLoading) {
      setLoading(true);
      update();
    }
    try {
      return await task.then((value) {
        if (withLoading) {
          setLoading(false);
          update();
        }
        if (value.status == ResponseStatus.failed) {
          setError(value.error);
          responseStatus = ResponseStatus.failed;
        } else {
          responseStatus = ResponseStatus.success;
        }
        return value;
      });
    } catch (e) {
      if (withLoading) {
        setLoading(false);
      }
      responseStatus = ResponseStatus.failed;

      if (e is DioException) {
        if (e.response != null) {
          ResponseModel res =
          ResponseModel.fromJson(e.response!.data, (json) => null);

          if (res.error?.code == GlobalConstants.NOT_SUPPORTED_ERROR_CODE ||
              res.error?.code == GlobalConstants.NOT_REGISTERED_ERROR_CODE) {
            showAppVersionMandatoryUpgradeDialog();
          }

          setError(res.error);
          if (res.error != null && res.error!.isUnAuthorized()) {
            await startAuthFlow();
          }
        } else {
          if(e.type==DioExceptionType.connectionError ||  e.type == DioExceptionType.connectionTimeout || e.type==DioExceptionType.receiveTimeout || e.type==DioExceptionType.sendTimeout) {
            setError(Error(code: 501, message: "${e.message}"));
          }
          else{
              setError(Error(code: 500, message: "${e.message}"));
          }
        }
      } else if (e is TypeError) {
        setError(Error(code: 500, message: "parsing_error".tr));
      } else {
        setError(Error(code: 500, message: "unknown_error".tr));
      }

      return ResponseModel.Error(error: error);
    }
  }

  bool isSuccess() {
    return responseStatus == ResponseStatus.success;
  }

  errorHandling(Error error) {
    if (error.code != GlobalConstants.NOT_SUPPORTED_ERROR_CODE &&
        error.code != GlobalConstants.NOT_REGISTERED_ERROR_CODE ) {
      Get.rawSnackbar(
          message: error.toString());
    }
  }


  void showAppVersionMandatoryUpgradeDialog() {
    Get.dialog(
        AppVersionUpdateDialog(
            AppUtils.openApplicationStorePage,
            AppUtils.exitApplication,
            true
        ),
        barrierDismissible : false,

        );
  }


  checkInternet() async {
    if (! await checkInternetFunction()) {
      if(GlobalConstants.isInternet) {
        Get.dialog(DialogAlert(
          title: "alert".tr,
          body: "check_your_internet".tr,
          buttonTitle: "ok".tr,
        )
        );
      }
      GlobalConstants.isInternet=false;
    }
    else {
      GlobalConstants.isInternet=true;
    }
  }

  }

