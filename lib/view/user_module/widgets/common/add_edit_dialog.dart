import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/functions/valid_input.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';


class AddEditDialog extends StatelessWidget {
  TextEditingController input1 = TextEditingController();
  TextEditingController input2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  String title;
  String? hint1;
  String icon;
  bool isEdit=false;
  String? hint2;
  bool isEmail = false;
  String initValue1 = "";
  String initValue2="";


  AddEditDialog({required this.title, this.hint1, required this.icon, this.hint2, this.isEdit=false, this.isEmail=false,this.initValue1="",this.initValue2="" ,super.key});

  @override
  Widget build(BuildContext context) {
    input1.text=initValue1;
    input2.text=initValue2;
    return Center(
      child: Wrap(
        children: [
          Dialog(
              insetPadding: const EdgeInsets.all(10),
              child:Container(
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 15 ),
                child:  Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            width: 15,
                            child: IconButton(
                                onPressed: (){
                                  Get.back();
                                },
                                icon: const Icon(Icons.close , size: 15,)),
                          ),
                          Text(title  ,style: const TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold , fontSize: 16),),
                          Container(width: 15,)
                        ],
                      ),
                      const SizedBox(height: 10),

                      if(hint1!=null)CustomTextField(
                        theController: input1,
                         hintText: hint1!,
                         keyboardType: isEmail? TextInputType.emailAddress:null,
                        validator: (val){
                          return isEmail? validInput(val, 5, 100, "email"):validInput(val, 3, 30, null);}
                      ),
                      if(hint2!=null)
                        CustomTextField(
                          theController: input2,
                          hintText: hint2??"",
                            validator: (val){
                              return validInput(val, 0, 30, null ,nullable: true );}
                        ),
                      CustomButtonWidget(
                          title: !isEdit? "add".tr:"save".tr,
                          backgroundColor: AppColor.secondaryColor,
                          textColor: AppColor.white,
                          icon: Image.asset(icon),
                          onPress: (){
                            if(formKey.currentState != null && formKey.currentState!.validate()) {
                              Get.back(result:{'input1':input1.value.text ,'input2': input2.value.text});
                            }
                          })
                    ],
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
