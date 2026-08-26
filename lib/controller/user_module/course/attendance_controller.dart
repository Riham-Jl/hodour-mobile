import 'dart:io';
import 'package:get/get.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/core/functions/hide_keyboard.dart';
import 'package:hodor/model/session_attendance.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/send_attendance_request.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import '../../../model/course.dart';
import '../../../model/session.dart';
import '../../../view/user_module/widgets/common/add_edit_dialog.dart';
import 'member_controller.dart';


class AttendanceController extends MemberController {
  late Session session;
  bool allChecked = false;
  int attendance = 0;

  bool filtered = false;

  late Course course;


  @override
  void onInit() async {
    course = Get.arguments['Course'];
    session = Get.arguments['Session'];
    getSessionAttendance();
    super.onInit();
  }

  Future<void> getSessionAttendance() {
    return networkCaller(
        restClient.getSessionResult(course.id, session.id))
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        attendance = 0;
        originList = value.data;
        searchedList = originList;
        for (SessionAttendance sessionAttendance in originList) {
          attendance += sessionAttendance.attendance;
        }
        update();
      }
      else if (error != null) {
        errorHandling(error!);
      }
    });
  }


  getSessionAttendanceExcel() {
    return
      restClient.getSessionResultExcel(course.id, session.id)
          .then((value) async {
        if (value.data != null) {
          Directory directory = await getApplicationDocumentsDirectory();
          File file = File('${directory.path}/day result ${session.id}.xlsx');
          await file.writeAsBytes(value.data);
          OpenFile.open(file.path);
        }
      });
  }

  changeAttendance(int id, int att) {
    originList
        .firstWhere((e) => e.id == id)
        .attendance = att;
    int z = originList.indexWhere((e) => e.attendance == 0);
    if (z == -1) {
      allChecked = true;
      attendance = originList.length;
    }
    else {
      allChecked = false;
      attendance=0;
      for (SessionAttendance sessionAttendance in originList) {
        attendance += sessionAttendance.attendance;
      }
    }

   update();
  }


  checkAll() {
    allChecked = !allChecked;
    for (var element in originList) {
      element.attendance = allChecked ? 1 : 0;
    }
     attendance = allChecked? originList.length:0;
    update();
  }


  addEditNote(int id , bool add){
    SessionAttendance attendance = originList.firstWhere((e) => e.id==id);
    Get.dialog( AddEditDialog(
      title: add? "add_note".tr:"${"show_note".tr} ${attendance.member_name}",
      hint2: "note".tr,
      initValue2: add? "" : attendance.note!,
      isEdit : !add,
      icon: AppImageAsset.addNoteBlue,
    )).then((value){
      if(value!=null) {
        attendance.note = value['input2']!=""? value['input2']:null;
        update();
      }
    });
  }
  


  sendAttendance(){
    List<SessionAttendance> sessionAttendance =[];
    for(SessionAttendance item in originList){
      sessionAttendance.add(item);
    }
    return networkCaller(
        restClient.sendAttendance(SendAttendanceRequest(course.id, session.id, sessionAttendance)) , withLoading: false)
        .then((value) async {
      if (value.status == ResponseStatus.success) {
             }
      else if (error != null) {
        errorHandling(error!);
      }

    });
  }


@override
  addMember()async{
    if(originList.isNotEmpty) sendAttendance();
    Get.dialog( AddEditDialog(
      title: "add_member".tr,
      hint1: "name".tr,
      hint2: "note".tr,
      icon: AppImageAsset.addMember,
    )).then((value) {
      if(value!=null) {
    add(course.id, value['input1'] ,value['input2'] , session.id).then((value) {
      if(value){
        getSessionAttendance();
      }
      });
  }});
  }

  @override
  searchItem(String value){
    filtered=false;
    searchStatus=true;
    if (value == "") {
      searchedList = originList;
    } else {
      searchedList = originList.where((e) => e.member_name.contains(value)).toList();
    }
    update();
  }

  @override
  closeSearch(){
    hideKeyboard();
    searchStatus=false;
    searchedList = filtered? originList.where((element) => element.attendance==0).toList():originList;
    searchController.clear();
    update();
  }

  filterAbsence(){
    filtered=!filtered;
    searchedList = filtered? originList.where((element) => element.attendance==0).toList():originList;

    update();
  }

  onPop(bool s) {
    if (originList.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 0), () {
        sendAttendance();
      });
    }
  }


}