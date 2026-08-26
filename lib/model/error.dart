import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable(explicitToJson: true)
class Error {
  int code;

  String message;

  Error({required this.code, required this.message});

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);

  @override
  String toString() {
    switch (code) {
      case 100:
        return "اسم المستخدم أو كلمة المرور خاطئة";
      case 101 :
       return "كلمة المرور غير صحيحة"  ;
      case 102:
        return "ليس لديك صالحية للوصول";
      case 103:
        return message;
      case 104:
        return "خطأ في المعطيات";
      case 105:
        return "انتهت صلاحية الجلسة يرجى تسجيل الدخول مرة أخرى";
        case 106:
        return "هذه النسخة من التطبيق غير مدعومة، يرجى تحديث التطبيق";
        case 107:
        return "هذه النسخة من التطبيق غير مدعومة، يرجى تحديث التطبيق";
        case 108:
        return "المستخدم غير موجود، تحقق من الإيميل";
        case 109:
        return "الدعوة مرسلة من قبل، بانتظار موافقة المدعو";
        case 110:
        return "لا يمكنك إرسال الدعوة إلى المسؤول عن التفقد";
        case 111:
        return "لا يمكنك إضافة تفقد جديد، لقد تجاوزت العدد المسموح لك";
        case 112:
        return "لا يمكنك إضافة أعضاء جدد لهذا التفقد، لقد تجاوزت العدد المسموح لك";
      case 501:
        return "لا يتوفر اتصال بالانترنت";

      case 500:
        return "فشل الاتصال";
    }
    return "ِِError #$code : $message";
  }

  bool isUnAuthorized (){
    return code == 105 ;
  }

}
