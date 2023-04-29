import 'dart:ui';

import 'package:champ_app/modules/game_module/view_model/endgame_vm.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/service_injector/service_injector.dart';
import '../../shared/models/match/match_score_model.dart';
import '../../shared/widgets/base_view.dart';

class ScoringScreen extends StatelessWidget {
  const ScoringScreen(
      {this.isLoss = true, this.score = 0, this.unityScoreModel});
  final bool isLoss;
  final int score;
  final UnityScoreModel? unityScoreModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<EndGameViewModel>(
      vmBuilder: (context) => EndGameViewModel(
          gameService: si.gameService,
          context: context,
          unityScoreModel: unityScoreModel),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, EndGameViewModel viewModel) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: white,
              size: 20.sp,
            )),
        title: Styles.bold(unityScoreModel!.youWon! ? 'You won!' : 'Lost',
            fontSize: 20.sp, color: white),
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    trophy,
                    width: 130.w,
                    height: 179.h,
                  ),
                  VSpace(27.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150.w,
                        height: 95.h,
                        decoration: BoxDecoration(
                          color: black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            VSpace(5.h),
                            Image.asset(
                              userColored,
                              width: 32.w,
                              height: 32.h,
                            ),
                            Styles.regular('Participants',
                                color: champTextGrey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                            Styles.regular('2',
                                color: white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                            VSpace(5.h),
                          ],
                        ),
                      ),
                      Container(
                        width: 167.w,
                        height: 95.h,
                        decoration: BoxDecoration(
                          color: black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            VSpace(5.h),
                            Image.asset(
                              stackedIcon,
                              width: 34.w,
                              height: 34.h,
                            ),
                            Styles.regular('Total Score',
                                color: champTextGrey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: unityScoreModel!.yourScore!
                                          .toString()),
                                  // TextSpan(
                                  //     text: '',
                                  //     style: TextStyle(
                                  //         fontSize: 10.sp,
                                  //         fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                            VSpace(5.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
