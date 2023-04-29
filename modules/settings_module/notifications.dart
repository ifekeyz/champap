import 'package:champ_app/modules/home_module/viewmodel/home_vm.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/service_injector/service_injector.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/space.dart';

class NotificationScreen extends StatelessWidget {
  final dynamic? notifResponse;
  const NotificationScreen({this.notifResponse});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      vmBuilder: (context) =>
          HomeViewModel(homeService: si.homeService, context: context),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, HomeViewModel viewModel) {
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
        title: Styles.bold('NOTIFICATION', fontSize: 20.sp, color: white),
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
                children: [
                  Container(
                    width: 120.1.w,
                    height: 114.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: darkBlue,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Image.asset(
                      chessBoard,
                      filterQuality: FilterQuality.high,
                      width: 95.05.w,
                      height: 88.55.h,
                    ),
                  ),
                  VSpace(20.h),
                  Styles.regular('Hi ${viewModel.homeContent.username!}',
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w600,
                      align: TextAlign.center,
                      color: champTextGrey),
                  VSpace(9.h),
                  Styles.regular(
                      '${notifResponse['sender_name']} ${notifResponse['title']}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      align: TextAlign.center,
                      color: white),
                  VSpace(9.h),
                  Styles.regular(
                      '${notifResponse['body']['game_type']} - ${notifResponse['body']['amount_stake']}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      align: TextAlign.center,
                      color: white),
                  VSpace(9.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          title: "Reject",
                          isActive: true,
                          onPress: () {
                            Navigator.pop(context);
                          }),
                      CustomButton(
                          title: "Accept",
                          isActive: true,
                          onPress: () {
                            viewModel.startMatch(
                              context,
                              notifResponse['body']['amount_stake'],
                              notifResponse['body']['game_type'],
                            );
                          }),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
