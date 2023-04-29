import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/utils/utils.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key, this.text, this.image}) : super(key: key);
  final String? text;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image!,
              height: 85.h,
              width: 85.w,
            ),
            Styles.bold(text!,
                color: white, fontSize: 24, align: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
