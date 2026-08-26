import 'dart:io';
import 'package:get/get.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/core/functions/date_functions.dart';
import 'package:hodor/model/member_attendance.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/course.dart';
import 'package:hodor/model/course_result.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class MemberResultsController extends BaseController{

  List<MemberAttendance> results=[];
   late Course course;
   late CourseResult courseResult;
   late int memberId;
   late String memberName;
   late String attendance;
   late String percentage;
   late double percentageNum;
   late String allDays;
    DateTime? startSession;
    DateTime? endSession;

  bool isExporting = false;



  @override
  void onInit() async{
    course = Get.arguments['Course'];
    startSession = Get.arguments['start_Session'];
    endSession = Get.arguments['end_Session'];
    courseResult = Get.arguments['result'];
    memberId = courseResult.member_id;
    memberName = courseResult.name;
    attendance = courseResult.attendance;
    percentage = courseResult.percentage;
    percentageNum= double.parse(percentage);
    allDays = courseResult.all_days.toString();
    getMemberResults();
    super.onInit();
  }

  Future<void> getMemberResults(){
    return networkCaller(
        restClient.getMemberResult(course.id , memberId ,  startSession!=null? getStringDateFromDateTime(startSession!):null , endSession!=null? getStringDateFromDateTime(endSession!):null))
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        results.clear();
        results = value.data;
        update();
      }
      else if (error != null) {
        errorHandling(error!);
      }

    });
  }

  Future<void> getMemberResultsExcel() async {
    if (isExporting) return;

    isExporting = true;
    update();

    return restClient
        .getMemberResultExcel(
      course.id,
      memberId,
      startSession != null
          ? getStringDateFromDateTime(startSession!)
          : null,
      endSession != null
          ? getStringDateFromDateTime(endSession!)
          : null,
    )
        .then((value) async {
      if (value.data != null) {
        Directory directory = await getApplicationDocumentsDirectory();

        File file = File(
          '${directory.path}/member result $memberName ${DateTime.now().millisecondsSinceEpoch}.xlsx',
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


}