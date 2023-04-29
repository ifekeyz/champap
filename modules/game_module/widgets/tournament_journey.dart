import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/color.dart';
import '../../../shared/utils/styles.dart';

Widget journey(String stage,  bool isWaiting, String player1ImageURL,  String player2ImageURL,String player1, String player2,) {
  return Container(
    width: double.infinity,
    height: 95.h,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
    decoration: BoxDecoration(
        color: stage == 'final' ? primaryColor : darkBlue,
        borderRadius: BorderRadius.circular(10.r)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Styles.regular(stage.toUpperCase(),
            color: white, fontSize: 16.sp, fontWeight: FontWeight.w600),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isWaiting) ...[
                  Styles.regular('?',
                        color: white.withOpacity(0.3),
                        fontSize: 62.sp,
                        fontWeight: FontWeight.w500,
                        align: TextAlign.center),
                ]else...[
                  CircleAvatar(
      backgroundImage: NetworkImage(
          player1ImageURL),
      radius: 26.r,
    ),
    VSpace(4.h),
    Styles.regular('@$player1', color: white, fontSize: 12.sp, fontWeight: FontWeight.w500)
                ]
                       
                  
              ],
            ),
            HSpace(30.w),
            Styles.regular('VS',
                color: white.withOpacity(0.3),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
            HSpace(30.w),
            Column(
              children: [
                if (isWaiting) ...[
                  Styles.regular('?',
                        color: white.withOpacity(0.3),
                        fontSize: 62.sp,
                        fontWeight: FontWeight.w500),
                ]else...[
                  CircleAvatar(
      backgroundImage: NetworkImage(
          player2ImageURL),
      radius: 26.r,
    ),
    VSpace(4.h),
    Styles.regular('@$player2', color: white, fontSize: 12.sp, fontWeight: FontWeight.w500)
                ]
                       
                  
              ],
            ),
          ],
        )
      ],
    ),
  );
}
