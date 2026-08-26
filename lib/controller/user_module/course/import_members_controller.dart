import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/user_module/home_controller.dart';
import 'package:hodor/core/constants/routes.dart';
import 'package:hodor/model/course.dart';

import '../../../view/user_module/pages/course/members_import_page.dart';
import 'member_controller.dart';


class ImportMembersController extends MemberController{
  HomeController homeController = Get.find();
  MemberController memberController = Get.put(MemberController());




  List<Course> courses=[];
  Course? selectedCourse;


  bool allChecked = false;
  int attendance = 0;




  @override
  void onInit() async{
    course = courseController.course!;
    courses = homeController.courses.where((element) => element.id!=course.id).toList();
    super.onInit();
  }


  openCourse( Course course) async{
    selectedCourse = course;
    await getMembers(selectedCourse );
    originList.forEach((member)  {
     member.attendance=false;
    });
    Get.bottomSheet(
        const MembersImportPage(),
        isScrollControlled:true
    );
  }


  changeAttendance(int id , bool attendance ){
    for(var c in originList){
    }


    searchedList.firstWhere((e) => e.id==id).attendance=attendance;
    int z = originList.indexWhere((e) => e.attendance==false);
    if(z==-1){
      allChecked=true;
    }
    else {
      allChecked=false;
    }

    update();
  }


  checkAll(){
    allChecked=!allChecked;
    for (var member in searchedList) {
      member.attendance=allChecked? true:false;
    }
    update();
  }
  
  
  importMembers(){
    List<Map> membersToAdd = [];
    originList.where((e) => e.attendance==true).forEach((member) {
      membersToAdd.add({'name':member.name , 'note':member.note});
    });
    addMembersByImport(membersToAdd, course.id).then((value){
      if(value){
        Navigator.pop(Get.context!);
        courseController.changePage(AppRoute.membersPage);
      }
    });
  }




}