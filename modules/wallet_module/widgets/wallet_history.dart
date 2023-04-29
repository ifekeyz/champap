import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'currency.dart';

Widget walletHistory({
  required BuildContext context,
  required String status,
  required String historyName,
  required String referrenceID,
  required String desc,
  required int amount,
  DateTime? dateCreated,
}) {
  return GestureDetector(
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.h),
      title: Styles.regular(historyName,
          fontSize: 14.sp, color: white, fontWeight: FontWeight.w600),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VSpace(8.h),
          Styles.regular(historyName,
              fontSize: 12.sp,
              color: champTextGrey,
              fontWeight: FontWeight.w500),
          VSpace(7.h),
          Styles.regular(referrenceID,
              fontSize: 12.sp, color: white, fontWeight: FontWeight.w500),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // VSpace(10.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: " ${currency(context).format(amount)}",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          VSpace(7.h),
          Styles.regular(dateCreated == null ? "-" : formatDate(dateCreated!),
              fontSize: 12.sp,
              color: champTextGrey,
              fontWeight: FontWeight.w500),
          VSpace(7.h),
          Styles.regular(status,
              fontSize: 10.sp,
              color: status == 'Successful'
                  ? champTextGreen
                  : status == 'Pending'
                      ? second
                      : Colors.red,
              fontWeight: FontWeight.w600),
        ],
      ),
    ),
  );
}
