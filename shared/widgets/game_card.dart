import 'dart:ui';

import 'package:champ_app/modules/game_module/select_game_mode.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';
import '../utils/styles.dart';

Widget game(
  BuildContext context,
  String imageURL,
  String gameName,
) {
  return Container(
    padding: EdgeInsets.only(right: 20.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Stack(
            children: [
              InkWell(
                onTap: gameName != "Ludo"
                    ? () {}
                    : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SelectGameMode(gameImg: imageURL)),
                        ),

                //   Navigator.push(
                // context,
                // MainRouter.generateRoute(
                //   const RouteSettings(name: RoutePaths.selectGameMode),
                // ),
                // ),
                child: Container(
                  width: 100.w,
                  height: 95.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: darkBlue,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Image.asset(
                    imageURL,
                    filterQuality: FilterQuality.high,
                    width: 85.1.w,
                    height: 73.h,
                  ),
                ),
              ),
              gameName != "Ludo"
                  ? Container(
                      width: 100.w,
                      height: 95.h,
                      decoration: BoxDecoration(
                          color: darkBlue.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Center(
                        child: Styles.regular("coming soon",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            align: TextAlign.center,
                            color: comingSoonGrey),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
        VSpace(5.h),
        Styles.regular(gameName,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            align: TextAlign.center,
            color: champTextGrey)
      ],
    ),
  );
}
