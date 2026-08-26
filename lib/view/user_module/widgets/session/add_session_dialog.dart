import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/functions/date_functions.dart';
import 'package:hodor/core/functions/valid_input.dart';

import '../common/custom_button.dart';
import '../common/custom_text_field.dart';




class AddEditSessionDialog extends StatelessWidget {

  String image;
  String title;
  String hint1;
  String hint2;
  String initValue2="";
  String button1Title;
  String button2Title;
  DateTime? session ;

  void Function() onPress2;


  AddEditSessionDialog({required this.image, required this.title, required this.hint1 , required this.hint2 , required this.button1Title,required this.button2Title,  required this.onPress2 ,  this.initValue2="", this.session, super.key});

  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController input1 = TextEditingController();

  TextEditingController input2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    input2.text=initValue2;
    session ??= DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    return  Center(
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
    padding: const EdgeInsets.symmetric(horizontal:  15 ),
    child: Form(
      key: formKey,
      child: Column(children: [
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
        Image.asset(image),
        StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
    return CustomTextField(
            readOnly: true,
              hintText: hint1,
            theController: input1,
            keyboardType: TextInputType.datetime,
            suffixIcon: const Icon(Icons.calendar_month_outlined , color: AppColor.grey,),
            onTap: (){
                showDatePicker(
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                context: Get.context!,
                initialDate:  DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2060))
            .then((value) {
                if (value != null) {
          setState(() {
            session = value;
            hint1 =getStringDateFromDateTime(value);
          });
                }});

            },

          );},
        ),
        CustomTextField(
            hintText:hint2,
          theController: input2,
            validator: (val){
              return validInput(val, 0, 25, null ,nullable: true );}
        ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: SizedBox(
                height: 55,
                child: CustomButtonWidget(
                    title: button1Title,
                    textColor: AppColor.white,
                    backgroundColor: AppColor.secondaryColor,
                    onPress: (){
                      print(session);
                      if(session!=null && formKey.currentState != null && formKey.currentState!.validate()) {
                        Get.back(result:{'input1':session ,'input2': input2.value.text});
                      }
                      }),
              )
              ),
            Expanded(
              child: SizedBox(
                height: 53,
                child: CustomButtonWidget(
                    title: button2Title,
                    textColor: AppColor.grey,
                    onPress: onPress2,
                            ),
              )
            )
          ],
        )

      ]),
    )))]
        ));
  }
}
