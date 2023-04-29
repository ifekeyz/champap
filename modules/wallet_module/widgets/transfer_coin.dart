import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/widgets/custom_button.dart';
import 'package:champ_app/shared/widgets/custom_text_form_field.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

transferCoin(
  BuildContext context,
) {
  return Container(
    height: 407.h,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: bottomSheetBlue,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Styles.regular('Transfer Champ Coin',
                  fontSize: 20.sp, fontWeight: FontWeight.w600, color: white),
              VSpace(8.h),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.777.w,
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
        CustomTextFormField(
          hintText: 'Enter player ID',
        ),
        VSpace(25.h),
        CustomTextFormField(
          hintText: 'Enter amount of champ coin',
        ),
        VSpace(55.h),
        CustomButton(
            title: "Transfer Champ Coins",
            isActive: true,
            onPress: () async {}),
      ],
    ),
  );
}
