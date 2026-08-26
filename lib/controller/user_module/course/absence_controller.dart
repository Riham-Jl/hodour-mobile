
import 'package:get/get.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/controller/user_module/course/session_controller.dart';

import 'package:hodor/model/session.dart';
import 'package:hodor/model/session_attendance.dart';
import 'package:hodor/model/recurrent_absent.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/course.dart';

import 'course_controller.dart';


class AbsenceController extends BaseController{
  CourseController courseController=Get.find();
  SessionController sessionController=Get.find();

   List<RecurrentAbsent> recurrentAbsence=[];
   Map days ={
     0:"last_days".trParams({
     "count":"3"
   }),
     1 : "last_days".trParams({
       "count":"5"
     }),
     2:"last_days".trParams({
       "count":"7"
     }),};

   List<SessionAttendance> sessionAbsence=[];

   int selectedindex=-1;
  late Course course;
  late List<Session> sessions;

  bool recurrentPressed=false;




  @override
  void onInit() async{
    course = courseController.course!;
    sessions=sessionController.originSessions;
   // getRecurrentAbsences();
    super.onInit();
  }

  getRecurrentAbsences(){
    return networkCaller(
        restClient.getRecurrentAbsences(course.id ))
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        recurrentAbsence = value.data;
        update();
      }
      else if (error != null) {
        errorHandling(error!);
      }

    });
  }

 changeSelectedIndex(int index , Session? session){
    if(selectedindex==index)
      {selectedindex=-1;
        sessionAbsence=[];
      }
    else
      {selectedindex=index;
    if(!recurrentPressed){
      getSessionAbsence(session!.id);
    }
      }
    update();
 }

 changeStatus(bool isRecurrentPressed){
    recurrentPressed=isRecurrentPressed;
    selectedindex=-1;
    if(isRecurrentPressed) sessionAbsence=[];
    update();
 }

 getSessionAbsence(int sessionId){
   return networkCaller(
       restClient.getSessionResult(course.id , sessionId))
       .then((value) async {
     if (value.status == ResponseStatus.success) {
       sessionAbsence = value.data;
       sessionAbsence = sessionAbsence.where((element) => element.attendance==0).toList();
       update();

     }
     else if (error != null) {
       errorHandling(error!);
     }

   });
 }

}