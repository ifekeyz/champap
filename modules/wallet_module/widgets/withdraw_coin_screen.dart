import 'package:champ_app/modules/wallet_module/widgets/enter_pin.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/widgets/custom_button.dart';
import 'package:champ_app/shared/widgets/custom_text_form_field.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../shared/models/withdraw_model.dart';
import '../view_model/coin_vm.dart';

class WithdrawCoinBTS extends StatelessWidget {
  final List<String>? bankNameList;
  final CoinViewModel viewModel;
  WithdrawCoinBTS({Key? key, this.bankNameList, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _accountNumber = TextEditingController();
    final TextEditingController _amount = TextEditingController();

    return Consumer<CoinViewModel>(builder: (context, viewModel, _) {
      // viewModel.getBankList();
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 12.w,
            right: 12.w,
            top: 16.h,
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Styles.regular('Withdraw Champ Coin',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: white),
                            VSpace(8.h),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.777.w,
                                child: Styles.regular(
                                    'Kindly select bank, enter account number',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: champTextGrey))
                          ]),
                    ),
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
                DropdownButtonFormField<String>(
                  dropdownColor: darkBlue,
                  validator: (value) =>
                      value == null ? 'Please select a bank' : null,
                  hint: Text(
                    "select a bank",
                    style: TextStyle(
                      color: white,
                      fontSize: 12.sp,
                    ),
                  ),
                  isExpanded: true,
                  items: bankNameList!.map((dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem!,
                        style: TextStyle(
                          color: white,
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => viewModel.onSelectedBank(value),
                  value: viewModel.selectedBank,
                  style: TextStyle(
                    color: white,
                    fontSize: 12.sp,
                  ),
                ),
                VSpace(25.h),
                CustomTextFormField(
                  hintText: 'Enter account number',
                  controller: _accountNumber,
                  onChanged: (value) {
                    viewModel.accName = "";
                    if (value.length == 10) {
                      viewModel.resolveAccountName(accNo: _accountNumber.text);
                    }
                  },
                ),
                VSpace(7.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Styles.regular(viewModel.accName,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        align: TextAlign.right,
                        color: champTextGrey),
                  ],
                ),
                VSpace(12.h),
                CustomTextFormField(
                  hintText: 'Enter amount',
                  controller: _amount,
                ),
                VSpace(30.h),
                CustomButton(
                    title: "Withdraw Naira",
                    isActive: true,
                    onPress: () {
                      Navigator.of(context).pop();
                      showModalBottomSheet(
                        enableDrag: true,
                        isDismissible: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return EnterPin(
                            withdrawModel: WithdrawModel(
                              amount: int.parse(_amount.text),
                              accountNumber: _accountNumber.text,
                              bankCode: viewModel.selectedBankCode,
                              accountName: viewModel.accName,
                              bankName: viewModel.selectedBank,
                            ),
                          );
                        },
                      );
                    }),
                VSpace(15.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
