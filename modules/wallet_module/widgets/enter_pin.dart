import 'package:champ_app/modules/wallet_module/widgets/num_pad.dart';
import 'package:champ_app/modules/wallet_module/widgets/pin_field.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../shared/models/withdraw_model.dart';
import '../view_model/coin_vm.dart';

class EnterPin extends StatelessWidget {
  final WithdrawModel withdrawModel;
  EnterPin({Key? key, required this.withdrawModel}) : super(key: key);

  final TextEditingController _pin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinViewModel>(builder: (context, viewModel, _) {
      // viewModel.getBankList();
      return DraggableScrollableSheet(
          initialChildSize: 0.78.h,
          minChildSize: 0.78.h,
          // maxChildSize: 0.78.h,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: bottomSheetBlue,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VSpace(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Styles.regular('Transfer Champ Coin',
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: white),
                                  VSpace(8.h),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.777.w,
                                      child: Styles.regular(
                                          'Enter  player’s ID and amount to transfer champ coin',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: champTextGrey))
                                ]),
                            IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  color: primaryColor,
                                  size: 25,
                                )),
                          ],
                        ),
                        VSpace(36.h),
                        buildPinPut(context, _pin, viewModel, withdrawModel),
                        VSpace(60.h),
                        NumPad(
                          buttonSize: 75,
                          buttonColor: Colors.transparent,
                          iconColor: white,
                          controller: _pin,
                          delete: () {
                            _pin.text =
                                _pin.text.substring(0, _pin.text.length - 1);
                          },
                          // do something with the input numbers
                          onSubmit: () {
                            debugPrint('Your code: ${_pin.text}');
                          },
                        )
                      ])),
            );
          });
    });
  }
}
