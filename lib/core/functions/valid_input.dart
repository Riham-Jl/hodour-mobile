import 'package:get/get.dart';

validInput (String? val , int min , int max , String? type  ,{nullable=false,password}){
  print(val);
  if (type=="email"){
    if(!GetUtils.isEmail(val??"")){
      return "email_validation_error".tr;
    }
  }

  if (type=="rePassword"){
    if(val!=password){
      return "password_not_identical".tr;
    }
  }

  if (!nullable &&( val==null || val=="")){
    return "empty_validation_error".tr;
  }

  if (!nullable && val!=null && val.length<min){
    return  "min_validation_error".trParams({
      "min": min.toString(),
    });
  }

  if (val!=null && val.length>max){
    return  "max_validation_error".trParams({
      "max": max.toString(),
    });
  }
  // return null;
}