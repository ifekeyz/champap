import 'dart:async';

import 'package:champ_app/modules/game_module/select_opponent.dart';
import 'package:champ_app/router/transitional_router.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadOpponent extends StatefulWidget {
  String stakeAmount;
  LoadOpponent({Key? key, required this.stakeAmount}) : super(key: key);

  @override
  State<LoadOpponent> createState() => _LoadOpponentState();
}

class _LoadOpponentState extends State<LoadOpponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    getPermissions();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    );
    _controller.forward();
  }

  getPermissions() async {
    // var status = await Permission.storage.status;
    // if (!status.isGranted) {
    //   // We didn't ask for permission yet or the permission has been denied before but not permanently.
    //   PermissionStatus s = await Permission.storage.request();
    //   if (s.isGranted) {
    //     print("dls");
    //     Timer(
    //         Duration(seconds: 3),
    //         () => Navigator.push(
    //               context,
    //               MainRouter.generateRoute(
    //                 RouteSettings(name: RoutePaths.loginFirstUser),
    //               ),
    //             ));
    //   } else {
    //     //close app
    //     print("close app here");
    //   }
    // }

    Timer(const Duration(seconds: 5),
        () => Navigator.push(context, TransitionalRoute(SelectOpponent())));
  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the 360*690(dp)
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
                    VSpace(16.h),
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                      child: Image.asset(loading, width: 108.w, height: 108.h),
                    ),
                    VSpace(7.h),
                    Styles.regular('Searching for opponent...',
                        color: loadingSubText,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                    VSpace(15.h),
                    Styles.regular('Token Stake',
                        color: loadingSubText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                    VSpace(4.h),
                    Styles.regular(widget.stakeAmount,
                        color: primaryColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700),
                    VSpace(10.h),
                  ])),
        ),
      ),
    );
  }
}
