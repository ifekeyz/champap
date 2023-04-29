// ignore_for_file: unused_import, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:champ_app/shared/widgets/space.dart';

import '../utils/color.dart';
import '../utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Color backgroundColor;
  final Color txtColor;
  final double height;
  final double elevation;
  final bool backBtn;

  CustomAppBar({
    this.txtColor = white,
    this.backgroundColor = black,
    this.title = 'title',
    this.subTitle,
    this.backBtn = true,
    this.elevation = 1,
    this.height = kToolbarHeight,
  });

  // Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shadowColor: backgroundColor,
      child: Container(
        height: height,
        decoration: BoxDecoration(color: backgroundColor),
        // padding: EdgeInsets.only(left: 24.w),
        child: Stack(
          children: <Widget>[
            !backBtn
                ? const SizedBox()
                : InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          // HSpace(length),
                          SizedBox(width: 24.w),
                          // FaIcon(
                          //   FontAwesomeIcons.chevronLeft,
                          //   color: txtColor,
                          //   size: 12.sp,
                          // ),
                          Icon(
                            Icons.arrow_back,
                            color: txtColor,
                            size: 20.sp,
                          ),
                          // HSpace(8.59.w),
                          // Styles.regular("Back",
                          //     color: txtColor, fontSize: 15.sp),
                        ],
                      ),
                    ),
                  ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Styles.medium(
                    title,
                    fontSize: 18.sp,
                    color: txtColor,
                  ),
                  subTitle == null ? SizedBox() : VSpace(5.h),
                  subTitle == null
                      ? SizedBox()
                      : Styles.semiBold(subTitle!,
                          fontSize: 12.sp, color: white)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
