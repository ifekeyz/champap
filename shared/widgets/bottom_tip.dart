
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bottomTip(
    BuildContext context,
    String text,
    ){
  return  Container(
    width: double.infinity,
    padding: EdgeInsets.only(
        left: 10.w, top: 12.h, bottom: 12.h, right:10.w),
    decoration: BoxDecoration(
      color: white.withOpacity(0.23),
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            child: Styles.regular(
                text,
                overflow: TextOverflow.clip,
                fontSize: 12.sp,
                fontWeight: FWt.regular,
                color: white),
          ),
          InkWell(
              onTap: () {},
              child: Image.asset(
                arrowUpOutlined,
                height: 21.h,
                width: 21.w,
              )),
        ]),
  );
}