import 'package:champ_app/shared/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget borderedText({required String text}) {
  return Stack(
    children: <Widget>[
      // Stroked text as border.
      Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5.w
            ..color = white,
        ),
      ),
      // Solid text as fill.
      Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
      ),
    ],
  );
}
