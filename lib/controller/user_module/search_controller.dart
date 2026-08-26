import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/core/functions/hide_keyboard.dart';
import 'package:hodor/model/course.dart';

import 'course/course_controller.dart';




 class SearchingController extends BaseController{

   CourseController courseController=Get.find<CourseController>();
   late Course course;

   List originList = [];
  List searchedList = [];
  bool searchStatus = false;
  TextEditingController searchController = TextEditingController();


  searchItem(String value ){
    searchStatus=true;
    if (value == "") {
      searchedList = originList;
    } else {
      searchedList = originList.where((e) => e.name.contains(value)).toList();
    }
    update();
  }

  closeSearch(){
    hideKeyboard();
    searchStatus=false;
    searchedList=originList;
    searchController.clear();
    update();
  }


}