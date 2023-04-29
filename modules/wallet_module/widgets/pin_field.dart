import 'package:champ_app/modules/wallet_module/view_model/coin_vm.dart';
import 'package:champ_app/shared/models/withdraw_model.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

Widget buildPinPut(
  BuildContext context,
  TextEditingController controller,
  CoinViewModel viewModel,
  WithdrawModel withdrawModel,
) {
  final defaultPinTheme = PinTheme(
    width: 70.w,
    height: 70.h,
    textStyle: const TextStyle(
        fontSize: 20, color: primaryColor, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: champTextGrey, width: 1),
      borderRadius: BorderRadius.circular(2.r),
    ),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: champTextGrey),
    borderRadius: BorderRadius.circular(2.r),
  );

  final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: Colors.transparent,
    ),
  );

  return Pinput(
    defaultPinTheme: defaultPinTheme,
    focusedPinTheme: focusedPinTheme,
    submittedPinTheme: submittedPinTheme,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    controller: controller,
    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
    readOnly: true,
    showCursor: true,
    obscureText: true,
    obscuringWidget: Container(
      width: 15.w,
      height: 15.h,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(50.r)),
    ),
    // onSubmitted: ,
    onCompleted: (pin) async {
      // Future.delayed(const Duration(milliseconds: 300), () {
      //
      //   Navigator.pop(context);
      // }).then((value) =>

      viewModel.confirmPin(context, pin: pin, withdrawModel: withdrawModel);

      // );
    },
  );
}
