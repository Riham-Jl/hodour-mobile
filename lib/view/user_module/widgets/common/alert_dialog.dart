import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'custom_button.dart';


class DialogAlert extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey();
  String title;
  String body;
  String buttonTitle;



  DialogAlert({required this.title, required this.body , required this.buttonTitle });

  @override
  Widget build(BuildContext context) {
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
                child:   Column(
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
                          Text(title  ,style: const TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold , fontSize: 18),),
                          Container(width: 15,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(body  ),
                      ),
                      Container(
                        width: Get.width*0.3,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: CustomButtonWidget(
                          title: buttonTitle,
                          textColor: AppColor.white,
                          backgroundColor: AppColor.secondaryColor,
                          onPress: (){
                            Get.back();
                          },
                        ),
                      ),

                    ],
                  ),

              )
          ),
        ],
      ),
    );
  }
}
