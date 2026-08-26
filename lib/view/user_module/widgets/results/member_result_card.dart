import 'package:flutter/material.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';
import 'package:hodor/core/functions/date_functions.dart';
import 'package:hodor/model/member_attendance.dart';

import '../common/custom_icon_button.dart';
import '../common/custom_list.dart';


class MemberResultCard extends StatelessWidget {
  const MemberResultCard({
    super.key,
    required this.result,
  });

  final MemberAttendance result;

  @override
  Widget build(BuildContext context) {
    return CustomList(
        title:Column(
          children: [
            Row(
              children: [
                Text("${getDayName(result.session)}  " , style: const TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold),),
                Text(result.sessionString() , style: TextStyle(color:result.attendance==0? AppColor.pink:AppColor.green , fontSize: 11, fontWeight: FontWeight.bold),),
              ],
            ),
            if(result.note!=null) Text(result.note! , style: const TextStyle(fontSize: 10),)
          ],
        ),
        icons:
        CustomIconButton(
          icon: result.attendance==1?AppImageAsset.attendanceSign: AppImageAsset.absenceSign,
          filled: true,
          color:result.attendance==0? AppColor.pink:null,

        )
    );
  }
}
