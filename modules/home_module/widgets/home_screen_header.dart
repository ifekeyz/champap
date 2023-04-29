import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/styles.dart';

Widget homeScreenHeader(
  BuildContext context,
  String userName,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 270.w,
            child: Styles.bold('Welcome ${userName.split(" ").first}',
                overflow: TextOverflow.ellipsis, fontSize: 25.sp, color: white),
          ),
          VSpace(5.h),
          Styles.regular('What would you like to do today?',
              fontSize: 14.sp, color: champTextGrey),
        ],
      ),
      const CircleAvatar(
        backgroundImage: NetworkImage(
            "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
        radius: 25,
      ),
    ],
  );
}
