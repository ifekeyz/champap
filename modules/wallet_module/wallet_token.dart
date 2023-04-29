import 'package:champ_app/modules/wallet_module/view_model/wallet_vm.dart';
import 'package:champ_app/modules/wallet_module/widgets/wallet_balance.dart';
import 'package:champ_app/modules/wallet_module/widgets/wallet_history.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/scroll_tag_action.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/service_injector/service_injector.dart';
import '../../shared/widgets/base_view.dart';

class WalletToken extends StatelessWidget {
  WalletToken({Key? key}) : super(key: key);

  // final List walletHistoryData = [
  //   {
  //     "name": "Withdrawal",
  //     "status": "Successful",
  //     "amount": 16000,
  //     "desc": "0125714121  Access Bank"
  //   },
  //   {
  //     "name": "Funding",
  //     "status": "Pending",
  //     "amount": 20000,
  //     "desc": "0125714121  Access Bank"
  //   },
  //   {
  //     "name": "Transfer",
  //     "status": "Pending",
  //     "amount": 16000,
  //     "desc": "To @gamesking"
  //   },
  //   {
  //     "name": "Game Winning",
  //     "status": "Successful",
  //     "amount": 170000,
  //     "desc": "From @gamesking"
  //   },
  //   {
  //     "name": "Funding",
  //     "status": "Declined",
  //     "amount": 20000,
  //     "desc": "0125714121  Access Bank"
  //   },
  //   {
  //     "name": "Transfer",
  //     "status": "Pending",
  //     "amount": 16000,
  //     "desc": "To @gamesking"
  //   },
  //   {
  //     "name": "Game Winning",
  //     "status": "Declined",
  //     "amount": 170000,
  //     "desc": "From @gamesking"
  //   },
  //   {
  //     "name": "Funding",
  //     "status": "Pending",
  //     "amount": 20000,
  //     "desc": "0125714121  Access Bank"
  //   },
  // ];

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
            image: DecorationImage(
                image: AssetImage(
                  bckgroundImg,
                ),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        walletBalance(
                            context,
                            'Champ Token Balance',
                            viewModel.totalToken.toString(),
                            true,
                            true,
                            viewModel),
                        VSpace(40.h),
                        scrollActionTag(
                            context, 'Token Transaction History', ''),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1.9,
                            child: ListView.builder(
                              itemCount: viewModel.tokenHistoryContent.length,
                              itemBuilder: (context, index) {
                                return walletHistory(
                                  context: context,
                                  status: "Successful",
                                  historyName: viewModel
                                      .tokenHistoryContent[index].name!,
                                  referrenceID: viewModel
                                      .tokenHistoryContent[index].userId
                                      .toString(),
                                  desc: viewModel
                                      .tokenHistoryContent[index].description!,
                                  amount: viewModel
                                      .tokenHistoryContent[index].token!,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
