import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/core/functions/date_functions.dart';
import 'package:hodor/core/functions/hide_keyboard.dart';
import 'package:hodor/core/functions/message_toast.dart';
import 'package:hodor/model/session.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/send_session_request.dart';
import 'package:hodor/model/course.dart';

import 'package:intl/intl.dart';

import '../../../view/user_module/pages/course/attendance_page.dart';
import '../../../view/user_module/widgets/common/alert_bottomsheet.dart';
import '../../../view/user_module/widgets/session/add_session_dialog.dart';
import 'course_controller.dart';

class SessionController extends BaseController{
  CourseController courseController = Get.find();
  late Course course;

  List<Session> originSessions=[];
  List<Map> sessions=[];


  @override
  void onInit() {
    course = courseController.course!;
    //getSessions();
    super.onInit();
  }


  Future<void> getSessions({bool withLoading = true}){
    return networkCaller(
        restClient.getSessions(course.id),
    withLoading: withLoading)
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        originSessions = value.data;

        afterGetSessions();
      }
      else if (error != null) {
        errorHandling(error!);
      }

    });
  }

  afterGetSessions(){
    sessions.clear();
    var groupByYear = groupBy(originSessions, (obj) => obj.session.year);
    groupByYear.forEach((year, list) {
      if(year==DateTime.now().year){
        var groupByMonth = groupBy(list, (obj) => obj.session.month);
        groupByMonth.forEach((month, list) {
          Map m ={'title':month};
          m['Sessions']=list;
          sessions.add(m);
        });
      }
      else {
        Map y = {'title':year};
        for (var listItem in list) {
          y['Sessions']=list;
        }
        sessions.add(y);
      }
    });

    update();
  }

  addSession(){
    Get.dialog( AddEditSessionDialog(
      title: "add_day".tr,
      hint1: getStringDateFromDateTime(DateTime.now()),
      hint2: "note".tr,
      image: AppImageAsset.addDate,
      button1Title: "add".tr,
      button2Title: "back".tr,
      onPress2: (){
        Get.back();
      },
    )).then((value) {
      if(value!=null){
        return networkCaller(
            restClient.addSession(SendSessionRequest(value['input1'], value['input2'], course.id)))
            .then((value) async {
              hideKeyboard();
          if (value.status == ResponseStatus.success) {

            goToAttendance(value.data);
            update();
          }
          else if (error != null) {
            if(error!.code==101){
              showMessageInToast("Session_exist".tr);
            }
            else{
            errorHandling(error!);
          }
          }
        });
      }});
  }

  editSession(Session session ){
    Get.dialog( AddEditSessionDialog(
      session: session.session,
      title: "edit_Session".tr,
      hint1: DateFormat('yyyy-MM-dd').format(session.session),
      hint2: "note".tr,
      initValue2: session.note??"",
      image: AppImageAsset.editDate,
      button1Title: "save".tr,
      button2Title: "delete_Session".tr,
      onPress2: (){
        Get.back();
        deleteSession(session);
      },
    )).then((value) {
      if(value!=null){
        return networkCaller(
            restClient.editSession(session.id , SendSessionRequest(value['input1'], value['input2'], course.id)))
            .then((value) async {
          if (value.status == ResponseStatus.success) {
            showMessageInToast("edited_successfully".tr);
            getSessions();
            update();

          }
          else if (error != null) {
            if(error!.code==101){
              showMessageInToast("Session_exist".tr);
            }
            else {
              errorHandling(error!);
            }
          }
        });
      }});
  }


  deleteSession(Session session ){
    Get.bottomSheet(
        AlertBottomSheet(
            image: AppImageAsset.deleteDate,
            title: "delete".tr,
            body: "confirm_delete_Session".trParams({
              "Session":session.sessionString().toString()
            }),
            buttonTitle: "delete".tr,
            onPress: ()
            {
              networkCaller(
                  restClient.deleteSession(session.id))
                  .then((value) async {
                    Get.back();
                if (value.status == ResponseStatus.success) {
                  showMessageInToast("deleted_successfully".tr);
                  originSessions.removeWhere((element) => element==session);
                  afterGetSessions();

                }
                else if (error != null) {
                  errorHandling(error!);
                }

              });
            }));
  }

  searchSession(){
    showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: Get.context!,
        initialDate:  DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2060))
        .then((value) {
      if(value!=null){
        int z = originSessions.indexWhere((element) => element.session.isAtSameMomentAs(value));
        if(z!=-1){
          Session? searchedSession = originSessions.firstWhere((element) => element.session.isAtSameMomentAs(value));
          goToAttendance(searchedSession);
        }
        else {
          hideKeyboard();
          showMessageInToast("Session_not_exist".tr);
        }
      }


    });
  }

  goToAttendance(Session session){
    Get.bottomSheet(
        const AttendancePage(),
        settings: RouteSettings(
            arguments: {"Course": course , "Session":session}),
        isScrollControlled:true
    ).then((value) {
      Future.delayed(const Duration(milliseconds: 400), ()
      {
        getSessions(withLoading: false);
      });
    });
  }

}