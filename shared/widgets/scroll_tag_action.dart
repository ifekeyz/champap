import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';
import '../utils/styles.dart';

Widget scrollActionTag(
  BuildContext context,
  String tag,
  String cta,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Styles.regular(tag, fontSize: 12.sp, color: champTextGrey),
     if(cta !=  '') 
      Row(children: [Styles.semiBold(cta, fontSize: 12.sp, color: primaryColor),  Icon(Icons.arrow_forward_ios_sharp, size: 16.sp, color: primaryColor)]),
     
    ],
  );
}