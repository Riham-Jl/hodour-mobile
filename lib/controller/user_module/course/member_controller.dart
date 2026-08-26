import 'package:get/get.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/controller/user_module/search_controller.dart';
import 'package:hodor/core/functions/hide_keyboard.dart';
import 'package:hodor/core/functions/message_toast.dart';
import 'package:hodor/model/member.dart';
import 'package:hodor/model/response_status.dart';
import 'package:hodor/model/send_members_request.dart';
import 'package:hodor/model/course.dart';

import '../../../view/user_module/widgets/common/add_edit_dialog.dart';
import '../../../view/user_module/widgets/common/alert_bottomsheet.dart';


class MemberController extends SearchingController{


  @override
  void onInit() async{

    course = courseController.course!;
   // getMembers(null);
    super.onInit();
  }


  Future<void> getMembers(Course? selectedCourse){
    return networkCaller(
        restClient.getMembers(selectedCourse!=null? selectedCourse.id: course.id))
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        originList = value.data;
        searchedList = originList;
        update();
      }
      else if (error != null) {
        errorHandling(error!);
      }

    });
  }

  addMember(){
    closeSearch();
    Get.dialog( AddEditDialog(
      title: "add_member".tr,
      hint1: "name".tr,
      hint2: "note".tr,
      icon: AppImageAsset.addMember,
    )).then((value) {

      if(value!=null) {
        add (course.id, value['input1'] ,value['input2'] , null);
      }
    });
  }


  add(int courseId , String name , String? note , int? sessionId){
    return networkCaller(
        restClient.addMember(courseId , name , note , sessionId))
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        showMessageInToast("added_successfully".tr);
        if(sessionId==null) {
          originList = value.data;
          searchedList = originList;
          update();
        }
        else {
          return true;
        }
      }
      else if (error != null) {
        if (error!.code == 101) {
          showMessageInToast("member_exist".tr);
        }
        else {
          errorHandling(error!);
        }
      }
    });
  }

  addMembersByImport(List<Map> newMembers , int courseId ){
    return networkCaller(
        restClient.addMembers(
            SendMembersRequest(newMembers, courseId, null)))
        .then((value) async {
      if (value.status == ResponseStatus.success) {
        showMessageInToast("added_successfully".tr);
          return true;
            }
      else if (error != null) {
        errorHandling(error!);
      }
    });
  }



  editMember(int memberId , String name , String? note ){
    Get.dialog( AddEditDialog(
      title: "edit_member".tr,
      hint1: "name".tr,
      hint2: "note".tr,
      isEdit: true,
      initValue1: name,
      initValue2: note??"",
      icon: AppImageAsset.editBlue,
    )).then((value) {
      hideKeyboard();
      closeSearch();
      if(value!=null){
      return networkCaller(
          restClient.editMember(memberId, value['input1'], value['input2']))
          .then((value) async {
        if (value.status == ResponseStatus.success) {
          showMessageInToast( "edited_successfully".tr);
         originList.firstWhere((element) => element.id==memberId).name=value.data.name;
          originList.firstWhere((element) => element.id==memberId).note=value.data.note;

          update();
        }
        else if (error != null) {
          if (error!.code == 101) {
            showMessageInToast( "member_exist".tr);
          }
          else {
            errorHandling(error!);
          }
        }
      });}
    });
  }

  deleteMember(Member member ){
    Get.bottomSheet(
        AlertBottomSheet(
            image: AppImageAsset.deleteUser,
            title: "delete".tr,
            body: "confirm_delete_member".trParams({
              "name": member.name,}),
            buttonTitle: "delete".tr,
       onPress: () {
        networkCaller(
          restClient.deleteMember(member.id))
          .then((value) async {
            Get.back();
        if (value.status == ResponseStatus.success) {
          showMessageInToast("added_successfully".tr);
          originList.removeWhere((element) => element==member);
          closeSearch();
          update();
        }
        else if (error != null) {
          errorHandling(error!);
        }
      });
    }));
  }




}