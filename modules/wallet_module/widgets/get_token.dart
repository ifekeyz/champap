import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/adManager.dart';

getToken(
  BuildContext context,
) {
  final adManager = AdManager();
  return Container(
    height: 322.h,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
              Styles.regular('Get Champ Token',
                  fontSize: 20.sp, fontWeight: FontWeight.w600, color: white),
              VSpace(8.h),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.777.w,
                  child: Styles.regular('How would you like to earn tokens',
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
        Row(
          children: [
            GestureDetector(
              onTap: () {
                adManager.addAds(true, true, true);
                adManager.showRewardedAd();
              },
              child: Container(
                width: 120.w,
                height: 112.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff030226),
                    borderRadius: BorderRadius.circular(2.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      video,
                      width: 64.w,
                      height: 46.92.h,
                    ),
                    VSpace(15.08.h),
                    Styles.regular('Watch Ads',
                        fontSize: 13.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.w500)
                  ],
                ),
              ),
            ),
            HSpace(19.w),
            GestureDetector(
              onTap: () {
                adManager.addAds(true, true, true);
                adManager.showRewardedAd();
              },
              child: Container(
                width: 120.w,
                height: 112.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff030226),
                    borderRadius: BorderRadius.circular(2.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      survey,
                      width: 45.2.w,
                      height: 56.5.h,
                    ),
                    VSpace(15.08.h),
                    Styles.regular('Take Survey',
                        fontSize: 13.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.w500)
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
