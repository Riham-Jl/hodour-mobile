import 'package:get/get.dart';

String setNotificationTime(Duration difference) {
  final isArabic = Get.locale?.languageCode == 'ar';

  int duration;
  String keySingle, keyPlural, keyTwo;

  if (difference.inDays >= 365) {
    duration = difference.inDays ~/ 365;
    keySingle = "year";
    keyPlural = "years";
    keyTwo = "two_years";
  } else if (difference.inDays >= 30) {
    duration = difference.inDays ~/ 30;
    keySingle = "month";
    keyPlural = "months";
    keyTwo = "two_months";
  } else if (difference.inDays != 0) {
    duration = difference.inDays;
    keySingle = "day";
    keyPlural = "days";
    keyTwo = "two_days";
  } else if (difference.inHours != 0) {
    duration = difference.inHours;
    keySingle = "hour";
    keyPlural = "hours";
    keyTwo = "two_hours";
  } else if (difference.inMinutes != 0) {
    duration = difference.inMinutes;
    keySingle = "minute";
    keyPlural = "minutes";
    keyTwo = "two_minutes";
  } else {
    duration = difference.inSeconds;
    keySingle = "second";
    keyPlural = "seconds";
    keyTwo = "two_seconds";
  }

  if (!isArabic) {
    return duration == 1
        ? "$duration ${keySingle.tr} ${"ago".tr}"
        : "$duration ${keyPlural.tr} ${"ago".tr}";
  }

  switch (duration) {
    case 1:
      return "${"ago".tr} ${keySingle.tr}";
    case 2:
      return "${"ago".tr} ${keyTwo.tr}";
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
      return "${"ago".tr} $duration ${keyPlural.tr}";
    default:
      return "${"ago".tr} $duration ${keySingle.tr}";
  }
}