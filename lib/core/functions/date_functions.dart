import 'package:get/get.dart';
import 'package:intl/intl.dart';

String getStringDateFromDateTime(DateTime date) {
  final locale = Get.locale?.languageCode ?? 'ar';
  return DateFormat('yyyy-MM-dd', locale).format(date);
}

String getMonthName(int month) {
  final locale = Get.locale?.languageCode ?? 'ar';

  if (month < 1 || month > 12) return "";

  final date = DateTime(2024, month);
  return DateFormat('MMMM', locale).format(date);
}

String getDayName(DateTime date) {
  final locale = Get.locale?.languageCode ?? 'ar';
  return DateFormat('EEEE', locale).format(date);
}

String getDaysTerm(int count) {
  final isArabic = Get.locale?.languageCode == 'ar';

  if (isArabic) {
    return count > 2 && count < 10
        ? 'days'.tr
        : 'day'.tr;
  }

  return count == 1
      ? 'day'.tr
      : 'days'.tr;
}