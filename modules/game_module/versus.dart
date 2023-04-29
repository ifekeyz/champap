import 'package:champ_app/modules/game_module/view_model/games_vm.dart';
import 'package:champ_app/shared/models/match_model.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/base_view.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/service_injector/service_injector.dart';

class Versus extends StatelessWidget {
  final List<DataFromMatch> matchData;
  final int amount;
  const Versus({Key? key, required this.matchData, required this.amount})
      : super(key: key);


  Future<void> _store() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('playerOne', matchData[0].users!.username ?? '' );
    await prefs.setString('playerTwo', matchData[1].users!.username ?? '' );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<GameViewModel>(
      vmBuilder: (context) => GameViewModel(
          gameService: si.gameService, context: context, isVersus: true),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, GameViewModel viewModel) {
    _store();
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: deviceWidth(context), maxHeight: deviceHeight(context)),
        designSize: Size(deviceWidth(context), deviceHeight(context)),
        orientation: Orientation.portrait);
    return Scaffold(
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

      ),
      body: Container(
        width: deviceWidth(context),
        height: deviceHeight(context),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(dottedImg),
          ),
        ),
        child: Center(
          child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 25.w, right: 25.w),
              height: 220.0.h,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 13.h, horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          player(matchData[0].users!.username ?? 'Tayo',
                              matchData[0].users!.avatar!
                              // femaleAvatar
                              ),
                          Container(
                            width: 57.w,
                            height: 57.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(50.r)),
                            child: Styles.regular('VS',
                                color: white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          player(matchData[1].users!.username ?? 'Emeka',
                              matchData[1].users!.avatar!
                              // maleAvatar
                              ),
                        ],
                      ),
                    ),
                    Styles.regular('Token Stake',
                        color: loadingSubText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                    Styles.regular('$amount',
                        color: primaryColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700),
                    VSpace(10.h),
                  ])),
        ),
      ),
    );
  }

  Widget player(String name, String avatar) {
    return Column(
      children: [
        Image.network(
          avatar,
          width: 82.w,
          height: 93.h,
        ),
        Styles.regular(name,
            color: black, fontSize: 16.sp, fontWeight: FontWeight.w600),
      ],
    );
  }
}
