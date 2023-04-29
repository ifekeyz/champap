import 'package:champ_app/modules/wallet_module/widgets/buy_coin.dart';
import 'package:champ_app/modules/wallet_module/widgets/get_token.dart';
import 'package:champ_app/modules/wallet_module/widgets/transfer_coin.dart';
import 'package:champ_app/modules/wallet_module/widgets/withdraw_coin_screen.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget walletBalance(
  BuildContext context,
  String name,
  String amount,
  bool isToken,
  bool showArrow,
  viewModel,
) {
  return Container(
    width: double.infinity,
    height: 141.h,
    margin: EdgeInsets.symmetric(vertical: 10.h),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: isToken ? purple : blue,
      borderRadius: BorderRadius.circular(4.r),
      image: const DecorationImage(
        image: AssetImage(
          walletBg,
        ),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Styles.medium(name,
                  fontSize: 12.sp,
                  color: isToken ? champTextBlue : white,
                  fontWeight: FWt.mediumBold,
                  align: TextAlign.start),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Styles.bold(amount,
                      fontSize: 42.sp,
                      color: isToken ? champTextBlue : white,
                      align: TextAlign.start),
                  Styles.regular(isToken ? 'Tokens' : 'Coins',
                      fontSize: 12.sp,
                      color: isToken ? champTextBlue : white,
                      fontWeight: FWt.semiBold,
                      align: TextAlign.start),
                ],
              ),
            ]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => isToken
                  ? _showGetTokenBottomSheet(context)
                  : _showBuyCoinBottomSheet(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: isToken
                        ? const Color(0xff3C2D70)
                        : const Color(0xFF211646),
                    borderRadius: BorderRadius.circular(3.r)),
                child: Styles.regular(isToken ? 'Get Champ Token' : 'Buy Coin',
                    color: white, fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
            ),
            if (!isToken)
              InkWell(
                onTap: () async {
                  await viewModel.getBankList();
                  _showWithdrawCoinBottomSheet(
                      context, viewModel.bankNameList, viewModel);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: isToken
                          ? const Color(0xff3C2D70)
                          : const Color(0xFF211646),
                      borderRadius: BorderRadius.circular(3.r)),
                  child: Styles.regular('Withdraw Naira',
                      color: white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            if (!isToken)
              InkWell(
                onTap: () => _showTransferCoinBottomSheet(context),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: isToken
                          ? const Color(0xff3C2D70)
                          : const Color(0xFF211646),
                      borderRadius: BorderRadius.circular(3.r)),
                  child: Styles.regular('Transfer Coin',
                      color: white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

// buy coin function
_showBuyCoinBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    isDismissible: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return buyCoin(
        context,
      );
    },
  );
}

// buy coin function
_showWithdrawCoinBottomSheet(BuildContext context, bankNameList, viewModel) {
  showModalBottomSheet<void>(
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    // backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    backgroundColor: darkBlue,
    context: context,
    builder: (BuildContext context) {
      return WithdrawCoinBTS(
        bankNameList: bankNameList,
        viewModel: viewModel,
      );
    },
  );
}

// transfer coin function
_showTransferCoinBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    isDismissible: true,
    // backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    backgroundColor: darkBlue,
    context: context,
    builder: (BuildContext context) {
      return transferCoin(
        context,
      );
    },
  );
}

// get token function
_showGetTokenBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    isDismissible: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return getToken(
        context,
      );
    },
  );
}
