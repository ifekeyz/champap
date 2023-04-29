import 'package:champ_app/shared/widgets/token_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/color.dart';
import '../../../shared/utils/images.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/custom_button.dart';

import '../../../shared/widgets/space.dart';
import '../../router/main_router.dart';
import '../../router/route_paths.dart';

class ProceedFundWallet extends StatelessWidget {
  ProceedFundWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.5.w, vertical: 24.h),
              child: Form(
                // key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        VSpace(24.h),
                        Image.asset(
                          wallet,
                          height: 123.h,
                          width: 132.w,
                        ),
                        VSpace(36.h),
                        Styles.bold("Fund Your Wallet to Proceed",
                            fontSize: 25.sp,
                            color: white,
                            align: TextAlign.center),
                        VSpace(20.h),
                        Styles.regular(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut.",
                            fontSize: 12.sp,
                            align: TextAlign.center,
                            color: champTextGrey),
                      ],
                    ),
                    VSpace(40.h),
                    tokenCard(context,'Champ Token', '2,000', true, false),
                    tokenCard(context,'Champ Coin', '0.00', false, false),
                    VSpace(40.h),
                    CustomButton(
                        title: "Proceed", isActive: true, onPress: () async { Navigator.push(
                                    context,
                                    MainRouter.generateRoute(
                                      const RouteSettings(
                                          name: RoutePaths.bottomNav),
                                    ),
                                  );}),
                    VSpace(90.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: white.withOpacity(0.23),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Styles.regular(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ',
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
