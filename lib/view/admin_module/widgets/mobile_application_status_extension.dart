import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../model/admin/admin_mobile_application.dart';

extension MobileApplicationStatusExtension on MobileApplicationStatus {
  String get apiValue {
    switch (this) {
      case MobileApplicationStatus.supported:
        return 'supported';

      case MobileApplicationStatus.optionalUpdate:
        return 'optional-update';

      case MobileApplicationStatus.forcedUpdate:
        return 'forced-update';
    }
  }

  String get title {
    switch (this) {
      case MobileApplicationStatus.supported:
        return 'supported'.tr;

      case MobileApplicationStatus.optionalUpdate:
        return 'optional_update'.tr;

      case MobileApplicationStatus.forcedUpdate:
        return 'forced_update'.tr;
    }
  }

  Color get color {
    switch (this) {
      case MobileApplicationStatus.supported:
        return AppColor.green;

      case MobileApplicationStatus.optionalUpdate:
        return AppColor.secondaryColor;

      case MobileApplicationStatus.forcedUpdate:
        return AppColor.pink;
    }
  }
}