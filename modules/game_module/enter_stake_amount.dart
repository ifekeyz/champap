import 'package:champ_app/modules/game_module/view_model/games_vm.dart';
import 'package:champ_app/modules/game_module/widgets/counter_button.dart';
import 'package:champ_app/modules/game_module/widgets/select_game_mode.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/custom_button.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../core/service_injector/service_injector.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/loading_overlay.dart';

class EnterStakeAmount extends StatelessWidget {
  EnterStakeAmount({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  Widget build(BuildContext context) {
    return BaseView<GameViewModel>(
      vmBuilder: (context) =>
          GameViewModel(gameService: si.gameService, context: context),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, GameViewModel viewModel) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const LoadingOverlay(
        image: logoImg,
        text: 'Searching for opponent...',
      ),
      overlayOpacity: 0.8,
      child: Scaffold(
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
              padding: EdgeInsets.only(
                  left: 25.w, top: 20.h, right: 25, bottom: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  gameMode(
                      context,
                      index,
                      index == 1 ? yellowCoin : blueCoin,
                      index == 1
                          ? 'Play With Champ Coin'
                          : 'Play With Champ Token'),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 40.h, left: 16.w, right: 16.w),
                    child: Column(
                      children: [
                        Styles.regular('Enter Amount To Stake',
                            color: champTextGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                        VSpace(13.h),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              counterButton(false, () {
                                viewModel.decreaseStakeAmount();
                              }),
                              Container(
                                width: 171.68.w,
                                height: 58.h,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(counterBg),
                                        fit: BoxFit.fill)),
                                child: Container(
                                  width: 154.28.w,
                                  height: 44.08.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(3.r)),
                                  child: Styles.regular(
                                      viewModel.stakeAmountOptions[
                                              viewModel.stakeAmount]
                                          .toString(),
                                      color: primaryColor,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              counterButton(true, () {
                                viewModel.increaseStakeAmount();
                              }),
                            ]),
                      ],
                    ),
                  ),
                  CustomButton(
                    title: 'Proceed',
                    onPress: () {
                      viewModel.startMatch(context, index);
                    },
                    isActive: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
