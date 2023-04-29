import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/color.dart';
import '../../../shared/utils/styles.dart';

Widget runnerUps(
  String imageSource,
  int pos,
) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 65.72.w,
        height: 65.72.h,
        decoration: BoxDecoration(
          image:  DecorationImage(
            image: NetworkImage(
                imageSource),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50.r)),
          border: Border.all(
            color: pos == 2 ?second : third,
            width: 2.0,
          ),
        ),
      ),
      Positioned(
        bottom: -10,
        right: 20,
        child: Container(
          width: 20.99.w,
          height: 20.99.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: pos == 2 ?second : third, borderRadius: BorderRadius.circular(50.r)),
          child: Styles.regular('$pos',
              fontSize: 10.sp, color: black, fontWeight: FontWeight.w700),
        ),
      ),
    ],
  );
}
