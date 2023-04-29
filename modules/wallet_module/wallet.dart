import 'package:champ_app/modules/wallet_module/view_model/wallet_vm.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/bottom_tip.dart';
import 'package:champ_app/shared/widgets/token_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/service_injector/service_injector.dart';
import '../../shared/widgets/base_view.dart';

class Wallet extends StatelessWidget {
  Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<WalletViewModel>(
      vmBuilder: (context) =>
          WalletViewModel(walletService: si.walletService, context: context),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, WalletViewModel viewModel) {
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
        title: Styles.bold('WALLET', fontSize: 20.sp, color: white),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // VSpace(35.h),
                      tokenCard(context, 'Champ Token',
                          viewModel.totalToken.toString(), true, true),
                      tokenCard(context, 'Champ Coin', viewModel.totalCoin,
                          false, true),
                    ],
                  ),
                  bottomTip(
                      context, 'What is difference between token and coin?'),
                ]),
          ),
        ),
      ),
    );
  }
}
