import 'package:get/get.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/model/admin/admin_mobile_application.dart';
import 'package:hodor/model/response_status.dart';

class AdminMobileApplicationsController extends BaseController {
  List<AdminMobileApplication> applications = [];
  @override
  void onInit() {
    getApplications();
    super.onInit();
  }

  Future<void> getApplications() async {

    final value = await networkCaller(
      restClient.adminMobileApplications(
      ),
    );

    if (value.status == ResponseStatus.success &&
        value.data != null) {

      applications = value.data!.data;

      update();

    } else if (error != null) {

      errorHandling(error!);
    }
  }

  Future<void> addApplication(String platform, String version, String status) {
    return networkCaller(restClient.adminAddMobileApplication(
            {'platform': platform, 'version': version, 'status': status}))
        .then((value) {
      if (value.status == ResponseStatus.success)
        getApplications();
      else if (error != null) errorHandling(error!);
    });
  }

  Future<void> deleteApplication(AdminMobileApplication app) {
    return networkCaller(restClient.adminDeleteMobileApplication(app.id))
        .then((value) {
      if (value.status == ResponseStatus.success) {
        applications.removeWhere((e) => e.id == app.id);
        update();
      } else if (error != null) errorHandling(error!);
    });
  }

  Future<void> updateApplication(
      AdminMobileApplication app,
      String platform,
      String version,
      String status,
      ) {

    return networkCaller(
      restClient.adminUpdateMobileApplication(
        app.id,
        {
          'platform': platform,
          'version': version,
          'status': status,
        },
      ),
    ).then((value) {

      if (value.status == ResponseStatus.success) {

        getApplications();

      } else if (error != null) {

        errorHandling(error!);
      }
    });
  }
}
