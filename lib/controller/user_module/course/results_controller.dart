import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/controller/user_module/course/session_controller.dart';
import 'package:hodor/controller/user_module/search_controller.dart';
import 'package:hodor/core/functions/date_functions.dart';
import 'package:hodor/core/constants/routes.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/sort_type.dart';
import 'package:hodor/model/course_result.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../view/user_module/widgets/results/filter_results_bottomsheet.dart';

class ResultsController extends SearchingController{
  SessionController sessionController=Get.find();


  DateTime? firstSession;
  DateTime? lastSession;


  SortType sortType = SortType.alphaAsc;
  DateTime? startSession;
  DateTime? endSession;
  bool isExporting = false;

  bool filterChanged = false;

  @override
  void onInit() {
    course = courseController.course!;
    updateSessionRange();
    if (sessionController.originSessions.isNotEmpty) {
      firstSession = sessionController.originSessions.last.session;
      lastSession = sessionController.originSessions.first.session;
    }

    super.onInit();
  }

  void updateSessionRange() {
    if (sessionController.originSessions.isNotEmpty) {
      firstSession = sessionController.originSessions.last.session;
      lastSession = sessionController.originSessions.first.session;
    } else {
      firstSession = null;
      lastSession = null;
    }
  }

  Future<void> getCourseResults(){
    return networkCaller(
        restClient.getAttendanceResult(course.id ,startSession!=null? getStringDateFromDateTime(startSession!):null , endSession!=null? getStringDateFromDateTime(endSession!):null))
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        originList = value.data;
        sortResults();
        searchedList = originList;
        update();
      }
      else if (error != null) {
        errorHandling(error!);
      }

    });
  }


  Future<void> getCourseResultsExcel() async {
    if (isExporting) return;

    isExporting = true;
    update();

    return restClient
        .getAttendanceResultExcel(
      course.id,
      startSession != null ? getStringDateFromDateTime(startSession!) : null,
      endSession != null ? getStringDateFromDateTime(endSession!) : null,
    )
        .then((value) async {
      if (value.data != null) {
        Directory directory = await getApplicationDocumentsDirectory();

        File file = File(
          '${directory.path}/Course result ${course.name} ${DateTime.now().millisecondsSinceEpoch}.xlsx',
        );

        await file.writeAsBytes(value.data);
        OpenFile.open(file.path);
      }

      isExporting = false;
      update();
    }).catchError((e) {
      isExporting = false;
      update();
      errorHandling(e);
    });
  }

  goToMemberResults(CourseResult result){
    Get.toNamed(AppRoute.memberResultsPage ,
        arguments: {
          'Course':course,
          'start_Session':startSession,
          'end_Session':endSession,
          'result':result
    });

  }


  chooseSortType(value){
    sortType = value;
    update();
  }

  openFilter() async {
    closeSearch();
    updateSessionRange();

    Get.bottomSheet(
      FilterBottomSheet(),
      isScrollControlled: true,
    );
  }

  void showDatePicker() {
    updateSessionRange();
    if (firstSession == null || lastSession == null) {
      Get.rawSnackbar(
        message: "no_sessions_to_filter".tr,
      );
      return;
    }

    showDateRangePicker(
      firstDate: firstSession!,
      lastDate: lastSession!,
      context: Get.context!,
    ).then((value) {
      if (value != null) {
        filterChanged = true;
        startSession = value.start;
        endSession = value.end;
        update();
      }
    });
  }

  resetFilter(){
    Get.back();
    if(startSession!=null || endSession!=null){
      startSession = null;
      endSession = null;
      getCourseResults();
    }
    if(sortType != SortType.alphaAsc){
      sortType = SortType.alphaAsc;
      sortResults();
    }
  }

  filter(){
    Get.back();
    if(filterChanged){
      getCourseResults();
      filterChanged=false;
    }
    else{
      sortResults();
    }
  }

   void sortResults (){
    switch (sortType) {
      case SortType.alphaAsc:
        originList.sort((a, b) => a.name.compareTo(b.name));
        break;

      case SortType.alphaDesc:
        originList.sort((a, b) => b.name.compareTo(a.name));
        break;

      case SortType.attendanceAsc:
        originList.sort((a, b) =>
            int.parse(a.attendance.toString()).compareTo(int.parse(b.attendance.toString())));
        break;

      case SortType.attendanceDesc:
        originList.sort((a, b) =>
            int.parse(b.attendance.toString()).compareTo(int.parse(a.attendance.toString())));
        break;
    }
    update();

  }

}



