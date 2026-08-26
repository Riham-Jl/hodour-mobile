import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';

import '../../../../controller/user_module/course/session_controller.dart';
import '../../../../core/functions/date_functions.dart';
import '../../widgets/common/data_container.dart';
import '../../widgets/common/main_container.dart';
import '../../widgets/common/search_text_field.dart';
import '../../widgets/session/add_session_card.dart';
import '../../widgets/session/session_card.dart';


class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionController>(builder: (controller) {
      return MainContainer(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchTextField(
            onTap: (){
              controller.searchSession();
            },
            readOnly: true,
        ),
          const SizedBox(height: 10,),
          Expanded(
            child:DataContainer(
              onRefresh: controller.getSessions,
              isLoading: controller.isLoading,
              isEmpty:  controller.sessions.isEmpty,
              emptyWidget:  ListView(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                        width: 90,
                        height: 105,
                        child: AddSessionCard(
                          onTap: (){
                            controller.addSession();
                          },
                        ),
                                      ),
                        Expanded(child: Container(),)
                      ],
                    ),
                    Image.asset(AppImageAsset.empty)
                  ],
                ),
                child: ListView.builder(
                  itemCount: controller.sessions.length,
                  itemBuilder: (context , i) {
                    int title = controller.sessions[i]['title'];
                    List sessions =  i==0 ? ['add button']:[];
                    sessions.addAll(controller.sessions[i]['Sessions']);
                    return
                      Column(
                        children: [
                          if(title!=DateTime.now().month) Padding(
                            padding: const EdgeInsets.only(top:15 , bottom: 5),
                            child: Text( title<=12? getMonthName(title):title.toString() , style: const TextStyle(fontSize:20,fontWeight: FontWeight.bold , color: AppColor.sessionCard ),),
                          ),
                          GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.8,
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(5),
                              itemCount: sessions.length,
                              itemBuilder: (BuildContext context, int index) {
                                return index==0 && i==0
                                    ? AddSessionCard(
                                  onTap: (){
                                    controller.addSession();
                                  },
                                )
                                    : SessionCard(
                                  session: sessions[index],
                                  title:title,
                                  onTap: (){
                                    controller.goToAttendance(sessions[index]);
                                  },
                                  onTapSettings: (){
                                    controller.editSession(sessions[index]);
                                  },
                                );
                              }),
                        ],
                      );
                  }),
                ),
          )
        
        ],
            ),
      );});
  }
}
