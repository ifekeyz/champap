import 'package:champ_app/shared/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/styles.dart';

Widget activeMatch(
  String bgImageURL,
  String gameName,
  String userName,
  int coin

) {
  return Container(
    width: 150.w,
    height: 96.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    margin: EdgeInsets.only(right: 20.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      image: DecorationImage(
        image: AssetImage(
          bgImageURL,
        ),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
              radius: 14,
            ),
            Column(
              children: [
                Styles.semiBold('\@$userName',
                    fontSize: 12.sp, color: white, align: TextAlign.center),
                Styles.bold('$coin coins',
                    fontSize: 12.sp,
                    color: primaryColor,
                    align: TextAlign.center),
              ],
            )
          ],
        ),
        Styles.semiBold(gameName,
            fontSize: 16.sp, color: white, align: TextAlign.center),
      ],
    ),
  );
}
