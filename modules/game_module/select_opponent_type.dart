import 'package:champ_app/modules/game_module/widgets/select_game_mode.dart';
import 'package:champ_app/modules/game_module/widgets/select_opponent_type.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/bottom_tip.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:champ_app/shared/widgets/token_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectOpponentType extends StatelessWidget {
  SelectOpponentType({Key? key, required this.index}) : super(key: key);
  int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: white,
              size: 20.sp,
            )),
      ),
      body: Container(
        width: deviceWidth(context),
        height: deviceHeight(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  bckgroundImg,
                ),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    
                    children: [
                      VSpace(76.h),
                      Image.asset(
                        index == 1?  yellowCoin: blueCoin,
                        width: 181.w,
                        height: 167.h,
                      ),
                      VSpace(105.h),
                      Styles.regular('Select Opponent Type',
                          color: white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                      VSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        opponentType(context,index,battle, 'Versus \nMode'),
                        HSpace(35.w),
                        opponentType(context,index,trophy, 'Tournament Mode'),
                      ])
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
