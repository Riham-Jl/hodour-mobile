import 'package:get/get.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/base_controlller.dart';
import 'package:hodor/core/functions/message_toast.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/course_user.dart';

import '../../../model/course.dart';
import '../../../view/user_module/widgets/common/add_edit_dialog.dart';
import '../../../view/user_module/widgets/common/alert_bottomsheet.dart';
import 'course_controller.dart' show CourseController;



class AdminsController extends BaseController{
  CourseController courseController=Get.find();
  List<CourseUser> users=[];
  List<CourseUser> invitedUsers = [];
  CourseUser? owner;
  late Course course;

  @override
  void onInit() async{
    course = courseController.course!;
    super.onInit();
  }


  Future<void> getUsers() async{
    return networkCaller(
        restClient.getUsers(course.id))
        .then((value) async {
      if (value.status == ResponseStatus.success) {
         users = value.data.where((e) => e.invited == false).toList();
        owner = users[0];
         invitedUsers = value.data.where((e) => e.invited == true).toList();
        update();

      }
      else if (error != null) {
        errorHandling(error!);
      }

    });
  }



  addUser(){
    Get.dialog( AddEditDialog(
      title: "add_admin".tr,
      hint1: "email".tr,
      icon: AppImageAsset.addMember,
      isEmail: true,
    )).then((value){
if(value!=null){
    return networkCaller(
        restClient.addUser(course.id ,value['input1']))
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        showMessageInToast("invitation_sent_successfully".tr);
        getUsers();
      }
      else if (error != null) {
        errorHandling(error!);
      }

    });}
    });
  }

  deleteUser(CourseUser user , int index , bool approved){
      Get.bottomSheet(
        AlertBottomSheet(
            image: AppImageAsset.deleteUser,
            title: "delete".tr,
            body: approved? "confirm_delete_admin".trParams({
              "name":user.name
            })
                :"confirm_cancel_invitation".trParams({
              "name":user.name
            }),
            buttonTitle: "delete".tr,
            onPress: (){
     networkCaller(approved?
        restClient.deleteUser(course.id , user.id):restClient.deleteInvitation(course.id, user.id))
        .then((value) async {
          Get.back();
      if (value.status == ResponseStatus.success) {
       approved?users.removeAt(index):invitedUsers.removeAt(index);
        update();

      }
      else if (error != null) {
        errorHandling(error!);
      }

    });
            }),

      );
  }
  }


