

import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

buyCoin(
    BuildContext context,

    ) {
  return Container(
    height: 407.h,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: bottomSheetBlue,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Styles.regular('Buy Champ Coin',
                  fontSize: 20.sp, fontWeight: FontWeight.w600, color: white),
              VSpace(8.h),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.777.w,
                  child: Styles.regular(
                      'To get champ coins simply make a transfer to the account number below',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: champTextGrey))
            ]),
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: primaryColor,
                  size: 25,
                )),
          ],
        ),
        VSpace(36.h),
         Styles.regular('Bank Name', fontSize: 12.sp, fontWeight: FontWeight.w500, color: champTextGrey),
        VSpace(8.h),
        Styles.regular('Wema Bank', fontSize: 18.sp, fontWeight: FontWeight.w600, color: white),
        VSpace(18.h),
        Styles.regular('Account Name', fontSize: 12.sp, fontWeight: FontWeight.w500, color: champTextGrey),
        VSpace(8.h),
        Styles.regular('Philip Templar', fontSize: 18.sp, fontWeight: FontWeight.w600, color: white),
        VSpace(18.h),

        Styles.regular('Account Number', fontSize: 12.sp, fontWeight: FontWeight.w500, color: champTextGrey),
        VSpace(8.h),
        Styles.regular('7810271033', fontSize: 18.sp, fontWeight: FontWeight.w600, color: white),
      
        VSpace(40.h),
        Styles.regular('*Note that 1 champ coin = 1 Naira*', fontSize: 13.sp, fontWeight: FontWeight.w300, color: primaryColor),

      ],
    ),
  );
}
