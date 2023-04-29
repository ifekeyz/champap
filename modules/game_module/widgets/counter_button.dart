import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget counterButton(
  bool isIncreement,
  Function() onTap,
) {
  return Container(
    width: 44.27.w,
    height: 35.59.h,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(counterBg)),
    ),
    child: IconButton(
      padding: const EdgeInsets.all(0),
      alignment: Alignment.center,
      icon: isIncreement
          ? Icon(
              Icons.add,
              color: primaryColor,
              size: 35.sp,
            )
          : Icon(
              Icons.remove,
              color: primaryColor,
              size: 35.sp,
            ),
      onPressed: onTap,
    ),
  );
}
