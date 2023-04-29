import 'package:champ_app/modules/game_module/enter_stake_amount.dart';
import 'package:champ_app/router/transitional_router.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget opponentType(
  BuildContext context,
  int index,
  String opponentAvatar,
  String text,
) {
  return Column(
    children: [
      InkWell(
        onTap: () => Navigator.push(
          context,
          TransitionalRoute(
            EnterStakeAmount(index: index),
          ),
        ),
        child: Container(
          width: 120.w,
          height: 114.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12.r)),
          child: Image.asset(
            opponentAvatar,
            width: 85.1.w,
            height: 75.h,
          ),
        ),
      ),
      VSpace(10.h),
      SizedBox(
          width: 90.w,
          child: Styles.regular(text,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              align: TextAlign.center,
              color: white))
    ],
  );
}
