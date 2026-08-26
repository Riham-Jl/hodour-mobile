import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/box_shadow.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/core/classes/image_picker.dart';
import 'package:hodor/core/functions/valid_input.dart';

import '../common/custom_button.dart';
import '../common/custom_text_field.dart' show CustomTextField;
import '../common/edit_image_bottom_sheet.dart';

class AddEditCourseDialog extends StatefulWidget {
  String? image ;
  String? pickedImage;
  bool isEdit=false;
  String initName = "";
  String initDescription="";
  bool? deleteImage;


  AddEditCourseDialog({this.image ,this.isEdit=false, this.initName="",this.initDescription="" ,super.key});

  @override
  State<AddEditCourseDialog> createState() => _AddEditCourseDialogState();
}

class _AddEditCourseDialogState extends State<AddEditCourseDialog> {

  TextEditingController name = TextEditingController();

  TextEditingController description = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();


  pickImage(bool camera)async{
    ImagePickerAndCrop imagePickerAndCrop = ImagePickerAndCrop();
    Get.back();
    await imagePickerAndCrop.pickAndCrop(camera).then((value){
      if(value!=null){
        setState(() {
          widget.pickedImage=value;
          widget.initName=name.text;
          widget.initDescription=description.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    name.text=widget.initName;
    description.text=widget.initDescription;
    return Center(
      child: Wrap(
        children: [
          Stack(
            clipBehavior: Clip.none,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              SizedBox(
                                width: 20,
                                child: IconButton(
                                    onPressed: (){
                                      Get.back();
                                    },
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.close , size: 20,)),
                              ),

                          const SizedBox(height: 35),
                          Center(child: Text(widget.isEdit
                              ?"edit_Course".tr
                              : "new_Course".tr  ,
                            style: TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold , fontSize: 16),)),
                          const SizedBox(height: 10),
                          CustomTextField(
                            theController: name,
                            hintText: "Course_name".tr,
                            validator: (val){
                              return validInput(val, 3, 15, null);}
                          ),

                          CustomTextField(
                              theController: description,
                              hintText: "Course_description".tr,
                                validator: (val){
                                  return validInput(val, 0, 25, null ,nullable: true );}

                            ),
                          CustomButtonWidget(
                              title: "save".tr,
                              backgroundColor: AppColor.secondaryColor,
                              textColor: AppColor.white,
                              icon: Image.asset(AppImageAsset.save),
                              onPress: (){
                                if(formKey.currentState != null && formKey.currentState!.validate()) {
                                  Get.back(result: {'name':name.text ,'description': description.text , 'image':widget.pickedImage , 'delete_image':widget.deleteImage});
                                }
                              })
                        ],
                      ),
                    ),
                  )
              ),
              Positioned(
                right: Get.width*0.5-60,
                top:-50,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10) ,
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: AppColor.white
                        ),
                        child:
                         widget.pickedImage==null
                         ? CircleAvatar(
                         foregroundImage: widget.image!=null?NetworkImage(widget.image!):null,
                          backgroundImage:const AssetImage(AppImageAsset.emptyImage),)
                         :CircleAvatar(
                          foregroundImage: FileImage(File(widget.pickedImage!)),
                      ),),
                      Positioned(
                        bottom: 5,
                          right: 5,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColor.white,
                                boxShadow: [
                                  buildBoxShadow()
                                ],
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                Get.bottomSheet(
                                  EditImageBottomSheet(
                                    existImage: widget.image!=null || widget.pickedImage!=null,
                                    onPressDelete:(){
                                      Get.back();
                                                    setState(() {
                                                      if(widget.image!=null) widget.deleteImage=true;
                                                      widget.image=null;
                                                      widget.pickedImage=null;
                                                      widget.initName=name.text;
                                                      widget.initDescription=description.text;
                                                    });
                                    } ,
                                    onPressGallery: (){pickImage(false);} ,
                                    onPressCamera: (){ pickImage(true);},
                                  )
                                    );
                              },
                              icon: Image.asset(AppImageAsset.editBlue),
                            ),

                          ))
                    ],
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}
