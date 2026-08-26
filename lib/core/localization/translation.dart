import 'package:get/get.dart';


class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "ar": {

      //general:
      "alert":"تنبيه!",
      "ok":"حسناً",
      "or":"أو",
      "welcome":"مرحباً بك",
      "edited_successfully":"تم التعديل بنجاح",
      "deleted_successfully":"تم الحذف بنجاح",
      "add":"اضافة",
      "back":"رجوع",
      "save":"حفظ",
      "delete":"حذف",
      "yes":"نعم",
      "no": "لا",
      "gallery":"معرض الصور",
      "camera":"الكاميرا",
      "search":"بحث",
      "accept":"قبول",
      "reject":"رفض",
      "edit":"تعديل",


      //update alert:
      "force_update_msg":"هذه النسخة من التطبيق لم تعد مدعومة٬ هل تريد تحديث التطبيق؟",
      "optional_update_msg":"تم إصدار نسخة جديدة من التطبيق  هل تريد تحديث التطبيق؟",



      //errors:
      "connection_failed":"فشل الاتصال",
      "unknown_error":"حدث خطأ ما",
      "parsing_error":"خطأ بالبيانات",
      "check_your_internet":"تحقق من جودة الاتصال بالانترنت",



      //auth:
      "login":"تسجيل الدخول",
      "email":"البريد الالتكروني",
      "password":"كلمة المرور",
      "login_with_google":"تسجيل الدخول باستخدام Google",
      "create_new_account":"إنشاء حساب جديد",
      "new_account":"حساب جديد",
      "username":"اسم المستخدم",
      "confirm_password":"تاكيد كلمة المرور",
      "create_account":"إنشاء حساب",
      "have_account":"لديك حساب مسبقاً؟",
      "logout":"تسجيل الخروج",
      "confirm_logout": "هل أنت متأكد من تسجيل الخروج من حساب\n@email",
      "out": "خروج",



      //profile:
      "edit_profile":"تعديل البروفايل",
      "edit_password":"تعديل كلمة المرور",
      "current_password":" كلمة المرور الحالية",
      "new_password":"كلمة المرور الجديدة",
      "confirm_new_password":"تاكيد كلمة المرور الجديدة",
      "choose_lang":"اختر اللغة",
      "language":"اللغة",


      //validation:
      "email_validation_error":"الرجاء إدخال بريد إلكتروني صحيح",
      "password_not_identical":"كلمتي المرور غير متطابقتين",
      "empty_validation_error":"لا يمكن أن يكون هذا الحقل فارغاً",
      "min_validation_error": "لا يمكن أن يقل عدد الأحرف عن @min",
      "max_validation_error": "لا يمكن أن يزيد عدد الأحرف عن @max",
      "image_size_validation":"يرجى تقليل حجم الصورة أو اختيار صورة أخرى بحجم أقل من 2 ميغابايت.",




      //Course:
      "attendance_notebook":"دفتر الحضور",
      "leave":"مغادرة",
      "delete_taffakkud":"حذف التفقد",
      "leave_Course":"مغادرة التفقد",
      "confirm_delete_leave_Course":"هل أنت متأكد من @action التفقد @Course نهائيا ؟\n لن نتمكن من اعادته في وقت لاحق",
      "pinned_successfully": "تم التثبيت بنجاح",
      "unpinned_successfully":"تم إلغاء التثبيت بنجاح",
      "add_member":"إضافة عضو",
      "name":" الاسم",
      "note":"ملاحظة",
      "added_successfully":"تمت الاضافة بنجاح",
      "member_exist":"الاسم موجود من قبل",
      "edit_member":"تعديل عضو",
      "confirm_delete_member":"هل أنت متأكد من حـذف العضو  @name نهائيا؟",
      "confirm_delete_Session":"هل أنت متأكد من حـذف الجلسة @Session نهائيا؟",
      "last_days":"آخر @count جلسات",
      "add_note":"إضافة ملاحظة",
      "show_note":"معاينة ملاحظة",
      "add_day":"اضافة جلسة",
      "Session_exist":"التاريخ موجود من قبل",
      "Session_not_exist":"التاريخ غير موجود",
      "edit_Session":"تعديل التاريخ",
      "delete_Session":"حذف الجلسة",
      "the_days":"الأيام",
      "recurrent_absence":"الغيابات المتكررة",
      "import":"استيراد",
      "members_name":"أسماء الأعضاء",
      "members_count":"عدد الأعضاء",
      "sessions_count":"عدد الجلسات",
      "attendance_days_count":"عدد أيام الحضور",
      "import_members":"استيراد الأعضاء",
      "select_Course":"اختر التفقد",
      "admins":"المسؤولون",
      "join_requests":"طلبات الانضمام",
      "add_admin":"إضافة مسؤول",
      "unselect_all":"إلغاء تحديد الكل",
      "select_all": "تحديد الكل",
      "from":"من",
      "to":"إلى",
      "sort_by":"ترتيب حسب",
      "from_a_to_z":"من أ الى ي",
      "from_z_to_a": "من ي الى أ",
      "from_max_to_min":"من الأعلى إلى الأدنى",
      "from_min_to_max":"من الأدنى إلى الأعلى",
      "filter_by_custom_range":"فلترة حسب فترة زمنية محددة",
      "no_sessions_to_filter":"لا يوجد جلسات للتصفية",
      "cancel_filtration":"الغاء الفلترة",
      "edit_Course":"تعديل دفتر التفقد",
      "new_Course":"دفتر تفقد جديد",
      "Course_name":"اسم التفقد",
      "Course_description":"وصف التفقد",
      "Course_settings":"إعدادات التفقد",
      "pin":"تثبيت",
      "unpin":"إلغاء تثبيت",
      "attendance_results":"نتائج التفقد",
      "absences":"الغيابات",
      "confirm_delete_admin":"هل أنت متأكد من حذف  المسؤول @name كمشرف على هذا التفقد",
      "confirm_cancel_invitation":"هل أنت متأكد من إلغاء دعوة @name ليكون مشرفاً على هذا التفقد؟",
      "invitation_sent_successfully":"تم إرسال الدعوة بنجاح",







      //notifications:
      "notifications":"الإشعارات",
      "all":"الكل",
      "join_invitations":"دعوات الانضمام",
      "invitation_accepted":"تم قبول الدعوة بنجاح",
      "invitation_rejected":"تم رفض الدعوة بنجاح",


  //notification time:
      "ago": "منذ",
      "year": "سنة",
      "years": "سنوات",
      "month": "شهر",
      "months": "أشهر",
      "day": "يوم",
      "days": "أيام",
      "hour": "ساعة",
      "hours": "ساعات",
      "minute": "دقيقة",
      "minutes": "دقائق",
      "second": "ثانية",
      "seconds": "ثوان",
      "two_years": "سنتين",
      "two_months": "شهرين",
      "two_days": "يومين",
      "two_hours": "ساعتين",
      "two_minutes": "دقيقتين",
      "two_seconds": "ثانيتين",


      //admin:
      "dashboard":"لوحة التحكم",
      "users":"المستخدمون",
      "courses":"التفقدات",
      "mobile_applications":"نسخ التطبيق",
      "system_overview":"نظرة عامة على النظام",
      "users_unit":"مستخدم",
      "members":"الأعضاء",
      "sessions":"الجلسات",
      "courses_unit":"تفقد",
      "admin":"مسؤول",
      "user":"مستخدم",
      "me":"حسابي",
      "add_user":"إضافة مستخدم",
      "allowed_courses_count":"عدد التفقدات المسموح",
      "allowed_members_count":"عدد الأعضاء المسموح",
      "type":"النوع",
      "no_courses":"لا يوجد تفقدات",
      "delete_user":"حذف المستخدم",
      "confirm_delete_user":"هل أنت متأكد من حذف @name؟",
      "edit_user":"تعديل المستخدم",
      "change_password":"تغيير كلمة المرور:",
      "is_admin":"مسؤول",
      "delete_course":"حذف التفقد",
      "confirm_delete_course":"هل أنت متأكد من حذف @name؟",
      "owner":"المالك",
      "course_owner":"مالك التفقد",
      "course_supervisors":"المسؤولون عن التفقد",
      "no_supervisors":"لا يوجد مسؤولون",
      "delete_version":"حذف النسخة",
      "confirm_delete_version":"هل أنت متأكد من حذف هذه النسخة؟",
      "add_version":"إضافة نسخة",
      "edit_version":"تعديل النسخة",
      "platform":"المنصة",
      "version":"الإصدار",
      "status":"الحالة",
      "supported":"مدعوم",
      "optional_update":"تحديث اختياري",
      "forced_update":"تحديث إجباري",
    },



    "en": {

//general:
      "alert":"Alert!",
      "ok":"OK",
      "or":"Or",
      "welcome":"Welcome",
      "edited_successfully":"Edited successfully",
      "deleted_successfully":"Deleted successfully",
      "add":"Add",
      "back":"Back",
      "save":"Save",
      "delete":"Delete",
      "yes":"Yes",
      "no": "No",
      "gallery":"Gallery",
      "camera":"Camera",
      "search":"Search",
      "accept":"Accept",
      "reject":"Reject",
      "edit":"Edit",

//update alert:
      "force_update_msg":"This version of the app is no longer supported. Do you want to update?",
      "optional_update_msg":"A new version of the app is available. Do you want to update?",

//errors:
      "connection_failed":"Connection failed",
      "unknown_error":"An error occurred",
      "parsing_error":"Data parsing error",
      "check_your_internet":"Check your internet connection",

//auth:
      "login":"Login",
      "email":"Email",
      "password":"Password",
      "login_with_google":"Login with Google",
      "create_new_account":"Create new account",
      "new_account":"New account",
      "username":"Username",
      "confirm_password":"Confirm password",
      "create_account":"Create account",
      "have_account":"Already have an account?",
      "logout":"Logout",
      "confirm_logout": "Are you sure you want to log out of the account\n@email?",
      "out": "Logout",


//profile:
      "edit_profile":"Edit profile",
      "edit_password":"Edit password",
      "current_password":"Current password",
      "new_password":"New password",
      "confirm_new_password":"Confirm new password",
      "choose_lang":"Choose language",
      "language":"Language",


//validation:
      "email_validation_error":"Please enter a valid email",
      "password_not_identical":"Passwords do not match",
      "empty_validation_error":"This field cannot be empty",
      "min_validation_error": "Minimum length is @min characters",
      "max_validation_error": "Maximum length is @max characters",
      "image_size_validation":"Please reduce image size or choose one less than 2MB.",

//Course (Attendance):
      "attendance_notebook":"Attendance Notebook",
      "leave":"Leave",
      "delete_taffakkud":"Delete attendance",
      "leave_Course":"Leave attendance",
      "confirm_delete_leave_Course":"Are you sure you want to @action attendance @Course permanently?\nThis cannot be undone",
      "pinned_successfully": "Pinned successfully",
      "unpinned_successfully":"Unpinned successfully",
      "add_member":"Add member",
      "name":"Name",
      "note":"Note",
      "added_successfully":"Added successfully",
      "member_exist":"Member already exists",
      "edit_member":"Edit Member",
      "confirm_delete_member":"Are you sure you want to delete member @name permanently?",
      "confirm_delete_Session":"Are you sure you want to delete Session @Session permanently?",
      "last_days":"Last @count sessions",
      "add_note":"Add note",
      "show_note":"View note",
      "add_day":"Add Session",
      "Session_exist":"Session already exists",
      "Session_not_exist":"Session does not exist",
      "edit_Session":"Edit Session",
      "delete_Session":"Delete Session",
      "the_days":"Days",
      "recurrent_absence":"Recurrent Absences",
      "import":"Import",
      "members_name":"Members Names",
      "members_count":"Members count",
      "sessions_count":"Sessions Count",
      "attendance_days_count":"Attendance Days Count",
      "import_members":"Import Members",
      "select_Course":"Select Attendance",
      "admins":"Admins",
      "join_requests":"Join requests",
      "add_admin":"Add admin",
      "unselect_all":"Unselect all",
      "select_all": "Select all",
      "from":"From",
      "to":"To",
      "sort_by":"Sort by",
      "from_a_to_z":"From A to Z",
      "from_z_to_a": "From Z to A",
      "from_max_to_min":"From highest to lowest",
      "from_min_to_max":"From lowest to highest",
      "filter_by_custom_range":"Filter by custom Session range",
      "no_sessions_to_filter":"There are no sessions available for filtering",
      "cancel_filtration":"Cancel Filtration",
      "edit_Course":"Edit Course",
      "new_Course":"New Course",
      "Course_name":"Course name",
      "Course_description":"Course description",
      "Course_settings":"Course settings",
      "pin":"Pin",
      "unpin":"Unpin",
      "attendance_results":"Attendance Results",
      "absences":"Absences",
      "confirm_delete_admin":"Are you sure you want to remove the administrator @name as a supervisor for this inspection?",
      "confirm_cancel_invitation":"Are you sure you want to cancel the invitation for @name to be a supervisor for this inspection?",
      "invitation_sent_successfully":"Invitation sent successfully.",

//notifications:
      "notifications":"Notifications",
      "all":"All",
      "join_invitations":"Join invitations",
      "invitation_accepted":"Invitation accepted successfully",
      "invitation_rejected":"Invitation rejected successfully",

////notification time:
      "ago": "ago",
      "year": "year",
      "years": "years",
      "month": "month",
      "months": "months",
      "day": "day",
      "days": "days",
      "hour": "hour",
      "hours": "hours",
      "minute": "minute",
      "minutes": "minutes",
      "second": "second",
      "seconds": "seconds",
      "two_years": "two years",
      "two_months": "two months",
      "two_days": "two days",
      "two_hours": "two hours",
      "two_minutes": "two minutes",
      "two_seconds": "two seconds",



      //admin:
      "dashboard":"Dashboard",
      "users":"Users",
      "courses":"Courses",
      "mobile_applications":"Mobile Applications",
      "system_overview":"System Overview",
      "users_unit":"users",
      "members":"Members",
      "sessions":"Sessions",
      "courses_unit":"courses",
      "admin":"Admin",
      "user":"User",
      "me":"Me",
      "add_user":"Add User",
      "allowed_courses_count":"Allowed Courses Count",
      "allowed_members_count":"Allowed Members Count",
      "type":"Type",
      "no_courses":"No courses",
      "delete_user":"Delete user",
      "confirm_delete_user":'Are you sure you want to delete @name?',
      "edit_user":"Edit user",
      "change_password":'Change Password:',
      "is_admin":'Is Admin',
      "delete_course":'Delete course',
      "confirm_delete_course":'Are you sure you want to delete @name?',
      "owner":"Owner",
      "course_owner":'Course Owner',
      "course_supervisors":'Course Supervisors',
      "no_supervisors": 'No supervisors',
      "delete_version": 'Delete version',
      "confirm_delete_version":'Are you sure you want to delete this version?',
      "add_version":"Add Version",
      "edit_version":"Edit Version",
      "platform":"Platform",
      "version":"Version",
      "status":"Status",
      "supported":"Supported",
      "optional_update":"Optional Update",
      "forced_update":"Forced Update",









    }

  };
}