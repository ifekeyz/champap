import 'package:champ_app/router/main_router.dart';
import 'package:champ_app/router/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';
import '../utils/images.dart';
import '../utils/styles.dart';

Widget tokenCard(
  BuildContext context,
  String name,
  String amount,
  bool isToken,
  bool showArrow,
) {
  return Container(
    width: double.infinity,
    height: 78.h,
    margin: EdgeInsets.symmetric(vertical: 10.h),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
    decoration: BoxDecoration(
      color: isToken ? purple : blue,
      borderRadius: BorderRadius.circular(4.r),
      image:  const DecorationImage(
        image: AssetImage(
          cardBg,
        ),
        fit: BoxFit.cover,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Styles.medium(name,
              fontSize: 12.sp,
              color: isToken? champTextBlue: white,
              fontWeight: FWt.mediumBold,
              align: TextAlign.start),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Styles.bold(amount,
                  fontSize: 42.sp,
                  color: isToken? champTextBlue: white,
                  align: TextAlign.start),
              Styles.regular( isToken ?  'Tokens': 'Coins',
                  fontSize: 12.sp,
                  color: isToken ?champTextBlue : white,
                  fontWeight: FWt.semiBold,
                  align: TextAlign.start),
            ],
          ),
        ]),
      if(showArrow)  
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MainRouter.generateRoute(
                   RouteSettings(
                      name: isToken? RoutePaths.walletToken: RoutePaths.walletCoin),
                ),
              );
            },
            child: Container(
              width: 36.w,
              height: 36.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:isToken? blue: white,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Image.asset(
                arrowRight,
                color: isToken? white: blue,
                height: 8.71.h,
                width: 15.7.w,
              ),
            ),
          ),
      ],
    ),
  );
}
