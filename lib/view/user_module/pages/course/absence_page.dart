import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hodor/core/functions/date_functions.dart';
import 'package:hodor/model/session.dart';

import 'package:intl/intl.dart';

import '../../../../controller/user_module/course/absence_controller.dart';
import '../../widgets/absence/absence_card.dart';
import '../../widgets/common/main_container.dart';
import '../../widgets/common/semi_circular_button_container.dart';

class AbsencePage extends StatelessWidget {
  const AbsencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AbsenceController>(builder: (controller) {
      return
          MainContainer(
            child: Column(
              children: [
                SemiCircularButtonContainer(
                    pressedOne: !controller.recurrentPressed,
                    title1: "the_days".tr,
                    title2: "recurrent_absence".tr,
                    onPressed1: (){
                      controller.changeStatus(false);
                    },
                    onPressed2: (){
                      controller.changeStatus(true);
                    }),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                  children:
                  controller.recurrentPressed
                      ?List.generate(controller.recurrentAbsence.length, (index) {
                      return  AbsenceCard(
                        recurrentAbsence: true,
                          data: controller.recurrentAbsence,
                          title1: controller.days[index],
                          absenceMembersCount: controller.recurrentAbsence[index].members.length.toString(),
                          onTap: (){
                            controller.changeSelectedIndex(index , null);
                          },
                          selectedIndex: controller.selectedindex,
                          index: index)
                        ;})
                      :List.generate(controller.sessions.length, (index) {
                        Session session = controller.sessions[index];
                    return AbsenceCard(
                      recurrentAbsence: false,
                        data: controller.sessionAbsence,
                        title1: getDayName( session.session),
                        title2: DateFormat('yyyy-MM-dd').format(session.session).toString(),
                        absenceMembersCount: (controller.course.members_count-int.parse(session.attendance!)).toString(),

                        onTap: (){
                          controller.changeSelectedIndex(index , session);
                        },
                        selectedIndex: controller.selectedindex,
                        index: index);
                   })

                                ),
                )

              ],
            ),
          );});


  }
}
