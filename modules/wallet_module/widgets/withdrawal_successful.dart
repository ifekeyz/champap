


import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/styles.dart';

import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

withdrawalSuccess(
    BuildContext context,

    ) {
  return Container(
    height: 407.h,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: bottomSheetBlue,
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(successfulWithdrawal, height: 289.h,
width: 255.w,

   
),
Styles.regular('Successful Withdrawal!', color: white, fontSize: 20.sp, fontWeight: FontWeight.w600),
VSpace(26.h),
InkWell(
  onTap: () => Navigator.pop(context),
  child: Styles.regular('Close', color: primaryColor, fontSize: 14.sp, fontWeight: FontWeight.w500, underline: true)),
      ],
    ),
  );
}
