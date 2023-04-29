import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/styles.dart';

class AuthOptions extends StatelessWidget {
  String imageURL, routeText;
  double fontSize;
  Function() onTap;

  AuthOptions(
      {Key? key,
      this.imageURL = '',
      this.routeText = '',
      required this.onTap,
      this.fontSize = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 155.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: white.withOpacity(0.2), width: 1.r),
          color: white.withOpacity(0.1),
        ),
        height: 47.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageURL, width: 20.w, height: 20.h),
            HSpace(10.w),
            Styles.semiBold(routeText, fontSize: fontSize, color: white),
          ],
        ),
      ),
    );
  }
}
