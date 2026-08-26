import 'package:flutter/material.dart';
import 'package:hodor/core/constants/box_shadow.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/core/functions/date_functions.dart';
import 'package:hodor/model/session.dart';

import '../common/empty_button.dart';


class SessionCard extends StatelessWidget {
  Session session;
  int title;
  void Function()? onTap;
  void Function()? onTapSettings;
   SessionCard({required this.session,required this.title, this.onTap, this.onTapSettings, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              buildBoxShadow(),
            ],
          ),

          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width:double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColor.sessionCard.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  children: [
                    Text(session.session.day.toString() , style: const TextStyle(color: AppColor.white , fontWeight: FontWeight.bold , fontSize: 30 ,height: 1),),
                    Text(title<=12? getDayName(session.session):getMonthName(session.session.month) ,  style: const TextStyle(color: AppColor.white , fontWeight: FontWeight.bold , fontSize: 12))
                  ],
                ),
              ),
              Expanded(child: Container(),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Text(session.attendance??"0" , style: const TextStyle(color: AppColor.white ),),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4 , right: 4),
                        child: Image.asset(AppImageAsset.membersIcon , color: AppColor.sessionCard.withOpacity(0.5),),
                      ),
                    ],
                  ),
                   EmptyButton(
                     onPressed: onTapSettings,
                       padding: 0,
                       child: const Icon(Icons.settings , size: 20, color: AppColor.primaryColor,))
                ],
              )
            ],
          )),
    );
  }


}
